<template>
  <div class="container">
    <div class="card" style="width: 60%;padding: 40px 30px">
      <el-form ref="formRef" :rules="data.rules" :model="data.form" label-width="80px" style="margin-top: 20px;margin-right: 50px;">

        <div style="width: 100%;display: flex;align-items: center;justify-content: center;margin-bottom: 20px">
          <el-upload
              class="avatar-uploader"
              action="http://localhost:8080/files/upload"
              :on-success="handleAvatarSuccess"
              :show-file-list="false"
          >
            <img v-if="data.form.avatar" :src=" data.form.avatar " class="avatar" />
            <el-icon v-else class="avatar-uploader-icon"><Plus /></el-icon>
          </el-upload> <!--上传头像-->
        </div>

        <el-form-item label="账号:" prop="username">
          <el-input disabled v-model="data.user.username" placeholder="请输入账号" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="名字:" porp="name">
          <el-input v-model="data.form.name" placeholder="请输入名字" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="手机号:" prop="phone">
          <el-input v-model="data.form.phone" placeholder="请输入手机号" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="邮箱:" prop="email">
          <el-input v-model="data.user.email" placeholder="请输入邮箱" autocomplete="off"></el-input>
        </el-form-item>
        <div style="text-align: center">
          <el-button @click="updateUser" type="primary" style="padding: 20px 30px">确认修改个人信息</el-button>
        </div>
      </el-form>

    </div>

  </div>
</template>

<script setup>
import {ref, reactive} from "vue";
import {Delete, Edit} from "@element-plus/icons-vue";
import request from "@/utils/request.js";
import {ElMessage} from "element-plus";

const data = reactive({
  user:JSON.parse(localStorage.getItem('xm-pet-mall-user')),
  form:{},
  rules: {
    name: [
      {required: true, message: '请输入名字', trigger: 'blur'},
    ],
    phone: [
      { required: true, message: '请输入手机号', trigger: 'blur' },
      { min: 11, max: 11, message: '格式错误', trigger: 'blur' }
    ]
  },
  sellPet:[],
  petTypeList:[],
})


const formRef = ref()

const handleAvatarSuccess = (res, file) => {
  console.log(res, data)
  data.form.avatar = res.data
}


// 获取用户信息,用于修改后刷新页面

if(data.user.role ==='USER') {
  request.get('/user/selectById/'+data.user.id).then(res => {
    data.form = res.data
  })
}


const emit = defineEmits(['updateUser'])

// 修改用户信息
const updateUser = () => {
  if(data.user.role ==='USER') {
    // 将sellPet转为json字符串
    data.form.sellPet = JSON.stringify(data.sellPet)
    request.put('/user/update', data.form).then(res => {
      if (res.code === '200') {
        ElMessage.success('修改成功')
        emit('updateUser')
        localStorage.setItem('xm-pet-mall-user', JSON.stringify(data.form))  //将新的用户信息存储到本地
        emit('updateUser')  //获取新数据
      } else {
        ElMessage.error(res.msg)
      }
    })
  }
}

</script>
<style scoped>
.container {
  display: flex;
  justify-content: center;

}

.avatar-uploader .avatar {
  width: 120px;
  height: 120px;
  display: block;
}
</style>

<style>
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
