<template>
  <div class="background-container" style="text-align: center;font-size: 50px;width: 100% ;height: 100%;" >
    <div class="admin-welcome"  v-if="data.user.role==='ADM'">
      <h1>欢迎来到管理者后台</h1>
      <div>
        这里是系统管理核心区域，您可以在此进行各项管理操作
      </div>
    </div>

    <div class="admin-welcome"  v-if="data.user.role==='PETSHOP'">
      <h1>欢迎来到商家后台</h1>
      <div>
        这里是商家管理核心区域，您可以在此进行各项管理操作
      </div>
    </div>
  </div>
</template>

<script setup>
import { reactive } from 'vue'

const data = reactive({
  form:{},
  user:JSON.parse(localStorage.getItem('xm-pet-mall-user'))
})

</script>

<style>
.admin-welcome {
  text-align: center;
  padding: 10px 20px;
}

.admin-welcome h1 {
  font-size: 2.8rem;
  font-weight: 600;
  background: linear-gradient(to right, #2c3e50, #4a6491);
  -webkit-background-clip: text;
  background-clip: text;
  color: transparent;
  margin-bottom: 20px;
  letter-spacing: 1px;
}

.admin-welcome div {
  font-size: 1.2rem;
  color: #666;
  max-width: 600px;
  margin: 0 auto;
  padding: 15px 25px;
  background: white;
  border-radius: 12px;
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
}


.background-container {
  /* 静态背景图设置 */
  background-image: url('@/assets/imgs/layer-0.png'); /* 替换为你的图片路径 */
  background-size: cover;
  background-position: center;
  background-repeat: no-repeat;

}

</style>