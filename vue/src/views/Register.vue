<template>
  <div class="login-container">

    <div class="login-box">
      <div style="text-align: center; height: 60px; font-size: 30px;font-weight: bold; color: #2b87ff">欢迎注册宠物商城</div>
      <el-form :model="data.form"  ref="formRef" :rules="data.rules" style="width: 250px">
        <el-form-item prop="username">
          <el-input style="width: 100%;" :prefix-icon="User" size="large" v-model="data.form.username" placeholder="请输入账号" />
        </el-form-item>
        <el-form-item prop="password">
          <el-input style="width: 100%;" :prefix-icon="Lock" size="large" v-model="data.form.password" placeholder="请输入密码" show-password />
        </el-form-item>
        <el-form-item prop="confirmPassword">
          <el-input  v-model="data.form.confirmPassword" show-password placeholder="确认密码" prefix-icon="Lock" ></el-input>
        </el-form-item>
        <el-form-item prop="role">
          <el-select v-model="data.form.role">
            <el-option value="USER" label="用户"></el-option>
            <el-option value="PETSHOP" label="宠物店主"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" style="width: 100%;" @click="register">注册</el-button>
        </el-form-item>
        <div style="text-align: right">已有账号，<a style="color: #049fff;text-decoration: none;" href="/login">登录</a>
        </div>
      </el-form>
    </div>

  </div>
</template>

<script setup>

import { reactive, ref } from 'vue'
import {User, Lock, Search} from '@element-plus/icons-vue'
import request from "@/utils/request.js";
import {ElMessage} from "element-plus";


// 验证密码是否一致
const validatePass = (rules, value, callback) => {
  if (value === '') {
    callback(new Error('请确认密码'))
  } else if (value !== data.form.password) {
    callback(new Error("两次密码输入不一致"))
  } else {
    callback()
  }
}


const data = reactive({
  form: {role:'USER'},
  rules: {
    username: [
      {required: true, message: '请输入账号', trigger: 'blur'},
    ],
    no: [
      {required: true, message: '请输入工号', trigger: 'blur'},
    ],
    password: [
      {required: true, message: '请输入密码', trigger: 'blur'},
    ],
    confirmPassword: [
      {validator: validatePass, trigger: 'blur'}
    ]
  }
})

const formRef = ref()

const register = () => {
  formRef.value.validate((valid) => {
    if (valid) {
      request.post('/register',data.form).then(res => {
            if(res.code === '200'){
              ElMessage.success('注册成功')
              setTimeout(() => {
                location.href = '/login'
              },500)
            }else {
              ElMessage.error(res.msg)
          }
      })
    }
  })
}


</script>

<style scoped>
.login-container {
  display: flex;
  align-items: center;
  justify-content: center;
  height: 100vh;
  background-image: url('@/assets/imgs/bg.jpg');
  background-size: cover;
}
.login-box {
  background-color: rgba(255,255,255,0.3); /* 透明0.1 */
  padding: 20px 50px;
  border-radius: 5px;
  box-shadow: 0 0 10px rgba(0,0,0,0.1);
}

</style>