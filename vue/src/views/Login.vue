<template>
  <div class="login-container">

    <div class="login-box">
      <div style="text-align: center; height: 60px; font-size: 30px; font-weight: bold; color: #2b87ff">宠 物 商 城</div>
      <el-form :model="data.form"  ref="formRef" :rules="data.rules" style="width: 250px">
        <el-form-item prop="username">
          <el-input style="width: 100%;" :prefix-icon="User" size="large" v-model="data.form.username" placeholder="请输入账号" />
        </el-form-item>
        <el-form-item prop="password">
          <el-input style="width: 100%;" :prefix-icon="Lock" size="large" v-model="data.form.password" placeholder="请输入密码" show-password />
        </el-form-item>
        <el-form-item prop="role">
          <el-select v-model="data.form.role">
            <el-option value="USER" label="用户"></el-option>
            <el-option value="PETSHOP" label="宠物店主"></el-option>
            <el-option value="ADM" label="管理员"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item>
          <el-button size="large" type="primary" style="width: 100%;" @click="login">登 录</el-button>
        </el-form-item>
        <div style="text-align: right">还没有账号？<a style="color: #049fff;text-decoration: none;" href="/register">立即注册</a>
        </div>
      </el-form>
    </div>

  </div>
</template>

<script setup>
import {reactive, ref} from "vue"
import request from "@/utils/request";
import {ElMessage} from "element-plus";
import router from "@/router";
import {User, Lock} from "@element-plus/icons-vue";

const data = reactive({
  form: {role:'USER'},
  rules: {
    username: [
      { required: true, message: '请输入用户名', trigger: 'blur' },
    ],
    password: [
      { required: true, message: '请输入密码', trigger: 'blur' },
    ],
  }
})

const formRef = ref()

const login = () => {
  formRef.value.validate((valid) => {
    if (valid) {
      request.post('/login',data.form).then(res => {
        if(res.code === '200'){
          //存储用户返回的信息
          localStorage.setItem('xm-pet-mall-user',JSON.stringify(res.data))
          ElMessage.success('登录成功')
          if(res.data.role === 'USER'){
            setTimeout(() => {
              location.href = '/front/home'
            },500)
          }else{
            setTimeout(() => {
              location.href = '/manager/home'
            },500)
          }
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