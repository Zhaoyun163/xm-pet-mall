<template>
  <div style="height: 100%;background-color: #eef8ff;">
    <!-- 顶部导航栏 -->
    <div style="background-color: #ffffff;height:60px;display: flex;align-items: center;justify-content: center">
      <div style="width: 180px;text-align: center;display: flex;color: #81cbff;margin-left: 10px;align-items: center">
        <img style="height: 40px;margin-right: 8px" alt="" src="@/assets/imgs/icon.png">
        <span style="font-size: 25px;font-weight: bold">宠物商城</span>
      </div>

      <!-- 中间导航栏信息 -->
      <div style="flex: 1;display: flex;justify-content: center;align-items: center">
        <div style="width: 800px;margin-left: 80px">
          <el-menu
              ellipsis
              class="el-menu-popper-demo"
              mode="horizontal"
              :popper-offset="0"
          >
            <el-menu-item style="margin: 0 20px"  @click="router.push('/front/home')">首页</el-menu-item>
            <el-menu-item style="margin: 0 20px"  @click="router.push('/front/petShop')">宠物店</el-menu-item>
            <el-menu-item style="margin: 0 20px"  @click="router.push('/front/pet')">宠物列表</el-menu-item>
            <el-menu-item style="margin: 0 20px"  @click="router.push('/front/goods')">宠物商品</el-menu-item>
            <el-menu-item style="margin: 0 20px"  @click="router.push('/front/shoppingCart')">购物车</el-menu-item>
            <el-menu-item style="margin: 0 20px"  @click="router.push('/front/order')">订单</el-menu-item>
          </el-menu>
        </div>
      </div>

      <!-- 头像和用户信息 -->
      <div style="display: flex;align-items: center;margin-right: 10px">
        <el-avatar
            :src=" data.user.avatar || 'https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png'"
        />
        <div>
          <el-dropdown>
            <span class="el-dropdown-link" style="color: #81cbff;margin-left: 10px;font-size: 20px;font-weight: bold">
              {{ data.user.name }}
              <el-icon class="el-icon--right">
                <arrow-down />
              </el-icon>
            </span>
            <template #dropdown>
              <el-dropdown-menu>
                <el-dropdown-item @click="router.push('/front/person')">
                  <el-icon>
                    <User/>
                  </el-icon>
                  个人信息
                </el-dropdown-item>
                <el-dropdown-item @click="router.push('/front/password')">
                  <el-icon>
                    <Lock/>
                  </el-icon>
                  修改密码
                </el-dropdown-item>
                <el-dropdown-item @click="router.push('/login')">
                  <el-icon>
                    <SwitchButton/>
                  </el-icon>
                  退出登录</el-dropdown-item>
              </el-dropdown-menu>
            </template>
          </el-dropdown>
        </div>
      </div>

    </div>

    <!-- 下面部分 -->
    <div>
      <RouterView @updateUser="updateUser"/>
    </div>
  </div>
</template>

<script setup>
import { reactive } from 'vue'
import router from "@/router/index.js";
import { ArrowDown } from '@element-plus/icons-vue'

const data = reactive({
  form:{},
  user:JSON.parse(localStorage.getItem('xm-pet-mall-user'))
})

const updateUser=(user)=>{
  data.user=JSON.parse(localStorage.getItem('xm-pet-mall-user'))
}
</script>

<style scoped>
/* 自定义 el-dropdown-menu 样式 */
.el-dropdown-menu {
  border: none !important; /* 移除边框 */
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1); /* 可选：添加阴影效果 */
}

/* 如果需要进一步调整其他样式，可以继续添加 */
</style>

<style scoped>
.example-showcase .el-dropdown-link {
  cursor: pointer;
  color: var(--el-color-primary);
  display: flex;
  align-items: center;
}

</style>
