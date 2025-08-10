<template>
  <div class="container">
    <div class="card" style="width: 60%; padding: 40px 30px">
      <div style="margin-bottom: 50px; font-size: 18px; font-weight: bold; color: #ff1414; text-align: center">
        一旦提交，宠物店铺将会对您的信息进行审核，将无法使用宠物店功能，请谨慎操作！
      </div>
      <el-form ref="formRef" :rules="data.rules" :model="data.form" label-width="80px" style="margin-top: 20px; margin-right: 50px;">
        <el-form-item prop="practiceLicense" lable="认证文件:">
          <el-upload
            class="avatar-uploader"
            action="http://localhost:8080/files/upload"
            :on-success="handleAvatarSuccess"
            :show-file-list="false"
          >
            <img v-if="data.form.practiceLicense" :src="data.form.practiceLicense" class="avatar" />
            <el-icon v-else class="avatar-uploader-icon"><Plus /></el-icon>
          </el-upload>
        </el-form-item>

        <el-form-item label="真实名字:" porp="principalName">
          <el-input v-model="data.form.principalName" placeholder="请输入真实名字" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="身份证号:" porp="principalNo">
          <el-input v-model="data.form.principalNo" placeholder="请输入身份证号" autocomplete="off" maxlength="18"></el-input>
        </el-form-item>
        <el-form-item label="审核状态:" porp="status">
          <el-tag type="info" v-if="data.form.status === '待提交'">待提交</el-tag>
          <el-tag type="warning" v-if="data.form.status === '待审核'">待审核</el-tag>
          <el-tag type="success" v-if="data.form.status === '审核成功'">审核成功</el-tag>
          <el-tag type="danger" v-if="data.form.status === '审核失败'">审核失败</el-tag>
        </el-form-item>

        <div style="text-align: center">
          <el-button @click="updateUser" type="primary" style="padding: 20px 30px">提 交</el-button>
        </div>
      </el-form>
    </div>
  </div>
</template>

<script setup>
import { ref, reactive } from "vue";
import { Delete, Edit } from "@element-plus/icons-vue";
import request from "@/utils/request.js";
import { ElMessage, ElMessageBox } from "element-plus";

const data = reactive({
  user: JSON.parse(localStorage.getItem("xm-pet-mall-user")),
  form: {},
  rules: {
    name: [
      { required: true, message: "请输入名字", trigger: "blur" },
    ],
    phone: [
      { required: true, message: "请输入手机号", trigger: "blur" },
      { min: 11, max: 11, message: "格式错误", trigger: "blur" },
    ],
  },
  sellPet: [],
  petTypeList: [],
});

const formRef = ref();

const handleAvatarSuccess = (res) => {
  data.form.practiceLicense = res.data;
};

// 获取用户信息,用于修改后刷新页面
data.form = JSON.parse(JSON.stringify(data.user));

// 获取用户信息,用于修改后刷新页面
if (data.user.role === "ADM") {
  request.get("/admin/selectById/" + data.user.id).then((res) => {
    data.form = res.data;
  });
} else if (data.user.role === "PETSHOP") {
  request.get("/petShop/selectById/" + data.user.id).then((res) => {
    data.form = res.data;
  });
}

const emit = defineEmits(["updateUser"]);

// 修改用户信息
const updateUser = () => {
  ElMessageBox.confirm("确认要提交审核吗？", "提交确认", { type: "warning" }).then(() => {
    data.form.sellPet = JSON.stringify(data.sellPet);
    request.put("/petShop/identify", data.form).then((res) => {
      if (res.code === "200") {
        ElMessage.success("提交成功，等待审核");
      } else {
        ElMessage.error(res.msg);
      }
    });
  }).catch();
};
</script>

<style scoped>
.container {
  display: flex;
  justify-content: center;

}

.avatar-uploader .avatar {
  width: 180px;
  height: 120px;
  display: block;
}

.avatar-uploader .el-upload {
  border: 1px dashed var(--el-border-color);
  border-radius: 20px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
  transition: var(--el-transition-duration-fast);
}

.avatar-uploader .el-upload:hover {
  border-color: var(--el-color-primary);
}

.el-icon.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 178px;
  height: 178px;
  text-align: center;
}
</style>