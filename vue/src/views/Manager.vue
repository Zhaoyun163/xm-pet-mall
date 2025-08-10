<template>
  <div>
    <!-- 顶部导航栏 -->
    <div style="background-color: #81cbff;height:60px;display: flex;align-items: center">
      <div style="width: 180px;text-align: center;display: flex;color: #ffffff;margin-left: 10px;align-items: center">
        <img style="height: 40px;margin-right: 8px" alt="" src="@/assets/imgs/icon.png">
        <span style="font-size: 25px;font-weight: bold">宠物商城</span>

      </div>
      <div style="flex: 1"></div>
      <div style="display: flex;align-items: center;margin-right: 10px">
        <el-avatar
            :src=" data.user.avatar || 'https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png'"
        />
        <div>
          <el-dropdown>
          <span class="el-dropdown-link" style="color: white;margin-left: 10px;font-size: 20px">
            {{ data.user.name }}
            <span v-if="data.user.role === 'PETSHOP' && data.user.status === '审核成功'">
                认证
            </span>
            <span v-if="data.user.role === 'ADM'">
                管理
            </span>
            <el-icon class="el-icon--right">
              <arrow-down />
            </el-icon>
          </span>
            <template #dropdown>
              <el-dropdown-menu>
                <el-dropdown-item @click="router.push('/manager/person')">
                  <el-icon>
                    <User/>
                  </el-icon>
                  个人信息
                </el-dropdown-item>
                <el-dropdown-item @click="router.push('/manager/identify')" v-if="data.user.role==='PETSHOP'">
                  <el-icon>
                    <User/>
                  </el-icon>
                  认证信息
                </el-dropdown-item>
                <el-dropdown-item @click="router.push('/manager/password')">
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

    <DIV STYLE="DISPLAY: FLEX;">
      <!-- 左侧菜单栏 -->
      <div style="width: 160px;border-right: 1px solid #bfbfbf;min-height: calc(100vh - 60px);">
        <el-menu router style="border: 0;width:160px" :default-active="router.currentRoute.value.path" >
          <el-menu-item index="/manager/home">
            <el-icon>
              <House/>
            </el-icon>
            系统菜单
          </el-menu-item>
          <el-sub-menu index="1" v-if="data.user.role==='ADM'">
            <template #title>
              <el-icon>
                <Avatar/>
              </el-icon>
              <span>用户管理</span>
            </template>
            <el-menu-item index="/manager/admin" v-if="data.user.role==='ADM'">管理员信息</el-menu-item>
            <el-menu-item index="/manager/petShop">
              宠物店主信息
            </el-menu-item>
            <el-menu-item index="/manager/user">
              普通用户信息
            </el-menu-item>
          </el-sub-menu>

          <el-sub-menu>
            <template #title>
              <el-icon>
                <Grid/>
              </el-icon>
              <span>信息管理</span>
            </template>
            <el-menu-item index="/manager/pet" v-if="data.user.role==='ADM' || (data.user.role==='PETSHOP' && data.user.status === '审核成功')">
              宠物信息
            </el-menu-item>
            <el-menu-item index="/manager/petType" v-if="data.user.role==='ADM'">
              宠物类型
            </el-menu-item>
            <el-menu-item index="/manager/goods" v-if="data.user.role==='ADM' || (data.user.role==='PETSHOP' && data.user.status === '审核成功')">
              商品信息
            </el-menu-item>
            <el-menu-item index="/manager/goodsType" v-if="data.user.role==='ADM'">
              宠物商品类型
            </el-menu-item>
            <el-menu-item index="/manager/slideshow" v-if="data.user.role==='ADM'">
              轮播图信息
            </el-menu-item>
            <el-menu-item index="/manager/order" v-if="data.user.role==='PETSHOP'">
              订单信息
            </el-menu-item>
          </el-sub-menu>

          <el-menu-item index="/login">
            <el-icon>
              <SwitchButton/>
            </el-icon>
            退出登录
          </el-menu-item>


        </el-menu>


      </div>

      <!-- 右侧内容栏 -->
      <div style="flex: 1;background-color: #eef8ff;padding: 10px;">

        <RouterView @updateUser="updateUser"/>
      </div>
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

<style>

.example-showcase .el-dropdown-link {
  cursor: pointer;
  color: var(--el-color-primary);
  display: flex;
  align-items: center;
  border:null;
}

.el-menu .is-active {
  background-color: #f4faff;
}

.el-sub-menu__title {
  background-color: white !important;
}
</style>