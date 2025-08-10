<template>
  <div class="container">
    <div class="card" style="width: 60%;padding: 40px 30px">
      <el-form ref="formRef" :rules="data.rules" :model="data.form" label-width="100px" style="margin-top: 20px;margin-right: 50px">
        <el-form-item label="原密码:" prop="password">
          <el-input show-password v-model="data.form.password" placeholder="请输入原密码" autocomplete="off" prefix-icon="Lock"></el-input>
        </el-form-item>
        <el-form-item  label="新密码:" prop="newPassword">
          <el-input show-password v-model="data.form.newPassword" placeholder="请输入新密码" autocomplete="off" prefix-icon="Lock"></el-input>
        </el-form-item>
        <el-form-item label="确认新密码:" prop="confirmPassword" required>
          <el-input show-password v-model="data.form.confirmPassword" placeholder="请确认新密码" autocomplete="off" prefix-icon="Lock"></el-input>
        </el-form-item>
        <div style="text-align: center">
          <el-button @click="updatePassword" type="primary" style="padding: 20px 30px">确认修改</el-button>
        </div>
      </el-form>
    </div>
  </div>

</template>

<script setup>
import { reactive ,ref } from "vue";
import request from "@/utils/request.js";
import {ElMessage} from "element-plus";

const validatePass = (rule, value, callback) => {
  if (value === null) {
    callback(new Error('请确认密码'))
  } else if (value !== data.form.newPassword) {
    callback(new Error("两次密码输入不一致"))
  } else {
    callback()
  }
}

const formRef = ref();

const data = reactive({
  user:JSON.parse(localStorage.getItem('xm-pet-mall-user')),
  form:{},
  rules: {
    password: [
        { required: true, message: '请输入原密码', trigger: 'blur' },
    ],
    newPassword: [
        { required: true, message: '请输入新密码', trigger: 'blur' },
    ],
    confirmPassword: [
        { validator: validatePass,  trigger: 'blur' },
    ],},

})

const updatePassword = () => {
  data.form.id = data.user.id
  data.form.role = data.user.role
  formRef.value.validate((valid) => {
    if (valid) {
      request.put('/updatePassword',data.form).then(res => {
        if(res.code === '200') {
          ElMessage.success('修改密码成功')
          localStorage.removeItem('xm-pet-mall-user') // 清除用户信息
          setTimeout(() => {
            location.href='/login'
          },500)
        }else{
          ElMessage.error(res.msg);
        }
      })
    }
  })

}
</script>

<style>
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