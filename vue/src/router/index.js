import { createRouter, createWebHistory } from 'vue-router'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    { path: '/',redirect: '/login',},

    //后台管理路由
    { path:'/manager',component: () => import('../views/Manager.vue'),children: [
        // 子路由不用/开头
        { path: 'home',name: 'home',meta: {title: '首页'}, component: () => import('../views/manager/Home.vue')},
        { path: 'admin',name: 'admin',meta: {title: '管理员数据页面'}, component: () => import('../views/manager/Admin.vue')},
        { path: 'petShop',name: 'petShop',meta: {title: '宠物店主数据页面'}, component: () => import('../views/manager/PetShop.vue')},
        { path: 'user',name: 'user',meta: {title: '普通用户数据页面'}, component: () => import('../views/manager/User.vue')},
        { path: 'person',name: 'person',meta: {title: '个人信息'}, component: () => import('../views/manager/Person.vue')},
        { path: 'identify',name: 'identify',meta: {title: '认证页面'}, component: () => import('../views/manager/Identify.vue')},
        { path: 'password',name: 'password',meta: {title: '密码信息'}, component: () => import('../views/manager/Password.vue')},
        { path: 'pet',name: 'pet',meta: {title: '宠物信息'}, component: () => import('../views/manager/Pet.vue')},
        { path: 'petType',name: 'petType',meta: {title: '宠物类型'}, component: () => import('../views/manager/PetType.vue')},
        { path: 'goodsType',name: 'goodsType',meta: {title: '宠物类型'}, component: () => import('../views/manager/GoodsType.vue')},
        { path: 'slideshow',name: 'slideshow',meta: {title: '轮播图信息'}, component: () => import('../views/manager/Slideshow.vue')},
        { path: 'goods',name: 'goods',meta: {title: '用品信息'}, component: () => import('../views/manager/Goods.vue')},
        { path: 'order',name: 'order',meta: {title: '订单信息'}, component: () => import('../views/manager/Order.vue')},

      ]},

    //前台路由
    { path: '/front',meta: {title: '宠物商城'},component: () => import('../views/Front.vue'),children: [
        { path: 'home', component: () => import('../views/front/Home.vue')},
        { path: 'person', component: () => import('../views/front/Person.vue')},
        { path: 'password', component: () => import('../views/front/Password.vue')},
        { path: 'petDetail', component: () => import('../views/front/PetDetail.vue')},
        { path: 'petShopDetail', component: () => import('../views/front/PetShopDetail.vue')},
        { path: 'petShop', component: () => import('../views/front/PetShop.vue')},
        { path: 'pet', component: () => import('../views/front/Pet.vue')},
        { path: 'goods', component: () => import('../views/front/Goods.vue')},
        { path: 'shoppingCart', component: () => import('../views/front/ShoppingCart.vue')},
        { path: 'order', component: () => import('../views/front/Order.vue')},

        ]},

    //登录注册路由
    { path: '/login',name: 'login',meta: {title: '登录页面'}, component: () => import('../views/Login.vue')},
    { path: '/register',name: 'register',meta: {title: '注册页面'}, component: () => import('../views/Register.vue')},
    { path: '/404',name: '404',meta: {title: '无效页面'}, component: () => import('../views/404.vue')},
    { path: '/:pathMatch(.*)*',redirect: '/404'}
  ],
})


router.beforeEach((to, from, next) => {
  document.title = to.meta.title;
  next()
})

export default router
