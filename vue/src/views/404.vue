<template>
  <div class="error-page">
    <div style="width: 150px; margin: 0 auto; height: 80px; display: flex; align-items: center; justify-content: center;">
      <el-button type="primary" @click="goHome">返回主页面</el-button>
    </div>
    <h1 style="color:#3e3e3e;font-size:40px">404 错误页面 </h1>
    <p>Sorry, the page you are looking for does not exist.</p>
    <div class="number-container">
      <span class="number">4</span>
      <span class="number">0</span>
      <span class="number">4</span>
    </div>

  </div>
</template>

<script setup>

import { reactive } from 'vue';

const data = reactive({
 // 从本地存储中获取用户信息并解析成JSON对象
user: JSON.parse(localStorage.getItem('xm-pet-mall-user')),

})

const goHome = () => {
  if (data.user.role === 'USER') {
    location.href = '/front/home';
  } else {
    location.href = '/manager/home';
  }
}




</script>

<style scoped>
.error-page {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  height: 100vh;
  background-color: #f0f2ff;
}

h1 {
  font-size: 2rem;
  margin-bottom: 1rem;
}

p {
  font-size: 1.2rem;
  color: #6c757d;
  margin-bottom: 2rem;
}

.number-container {
  display: flex;
  gap: 1rem;
  margin-bottom: 2rem;
}

.number {
  font-size: 6rem;
  font-weight: bold;
  background: linear-gradient(135deg, #5954ff, #25ffd8);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  animation: gradientAnimation 5s infinite;
}

@keyframes gradientAnimation {
  0% {
    background-position: 0% 50%;
  }
  50% {
    background-position: 100% 50%;
  }
  100% {
    background-position: 0% 50%;
  }
}

button {
  padding: 0.75rem 1.5rem;
  font-size: 1rem;
  background-color: #e91e63;
  color: white;
  border: none;
  border-radius: 0.25rem;
  cursor: pointer;
  transition: background-color 0.3s;
}

button:hover {
  background-color: #d81b60;
}
</style>