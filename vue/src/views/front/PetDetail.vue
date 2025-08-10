<template>
  <div class="container">
    <div class="card" style="align-items: center;margin: 20px 0">
      <div style="display: flex">
        <div style="flex:1;padding: 0;margin: 10px 10px;">
          <img :src="data.form.img" alt="" style="width: 400px; height:400px;display: block;border-radius: 20px">
        </div>
        <div  :v-if="Object.keys(data.form).length > 0" style="flex:1;padding: 0;margin: 10px 10px;">
          <div style="font-size: 25px;font-weight: bold;margin-bottom: 10px">{{data.form.name}}</div>
          <div class="shop-info">
            <span style="color: #666">宠物店：</span>
            <img :src="data.formShop.avatar" class="shop-avatar" alt="" style="cursor: pointer" @click="router.push('/front/petShopDetail?id='+ data.form.shopId)">
            <span class="shop-name">{{data.form.shopName}}</span>
          </div>

          <div style="margin-bottom: 10px"><span style="color: #666">宠物类别：</span>{{data.form.typeName}}</div>
          <div style="margin-bottom: 10px"><span style="color: #666">宠物性别：</span>{{data.form.sex}}</div>
          <div style="margin-bottom: 10px;color:red;font-size: 30px"><span
              style="color: #666;font-size: 14px">宠物价格：</span>${{data.form.price}}</div>
          <div style="margin-bottom: 10px;"><span style="color: #666">宠物介绍：</span>{{data.form.introduce}}</div>
          <el-button type="primary"  @click="router.push('/front/home')">返回首页</el-button>

          <el-button type="success" size="medium" @click="orderAdd(data)">下单购买宠物</el-button>


        </div>
      </div>
      </div>

    <div class="card" style="align-items: center;">
      <div style="font-size: 25px;font-weight: bold;margin:10px 10px;text-align: center">宠物详情</div>
      <div style=" border-bottom: 2px solid #eee;margin: 10px 10px;"></div>
      <div class="editor-content-view" style="padding:20px" v-html="data.form.content"></div>
    </div>



  </div>
</template>

<script setup>
import { reactive } from 'vue'
import request from "@/utils/request.js";
import { onMounted } from 'vue';
import { useRoute } from 'vue-router';
import router from "@/router/index.js";
import {ElMessage} from "element-plus";

const data = reactive({
  form:{},
  formShop:{},
  user: JSON.parse(localStorage.getItem('xm-pet-mall-user')),


})

// 下单
const orderAdd = (data) => {

  const generateOrderNo = () => {
    const timestamp = Date.now(); // 当前时间戳
    const randomNum = Math.floor(Math.random() * 1000); // 随机数（0-999）
    return `ORD-${timestamp}-${randomNum}`;
  };

  const orderNo = generateOrderNo(); // 调用函数生成订单编号

  request.post('/order/add', {
    status:'未发货',
    orderNo: orderNo, // 新增订单编号字段
    name: data.form.name,
    shopId:data.form.shopId,
    userId: data.user.id,
    number: 1,
    img:data.form.img,
    price:data.form.price,


  }).then(res => {
    if (res.code === '200') {
      ElMessage.success('添加成功');
      load(); // 重新加载商品列表，或者你可以选择不重新加载，而是更新 quantityMap 中的对应值
    } else {
      ElMessage.error(res.msg);
    }
  });
};


const route = useRoute();

onMounted(() => {
  // 从路由中获取查询参数
  const id = route.query.id;
  // 请求数据
  request.get('/pet/selectAll',{
    params:{
      id:id,
      typeName:''
    }
  }).then(res => {
    // res.data是一个数组，数组的第一个元素是当前宠物的详情数据
    data.form = res.data[0];

    // 确保shopId存在，再请求宠物店数据
    request.get('/petShop/selectById/'+data.form.shopId,{

    }).then(res => {
      data.formShop = res.data
      console.log(data.formShop)
    })
  })

})




</script>

<style scoped>
.container {
  width: 60%;
  margin: 0 auto;
  min-height: calc(100vh - 60px);
}

</style>
<style scoped>
.shop-info {
  display: flex;
  align-items: center;
  gap: 8px;
  margin-bottom: 10px;
}
.shop-avatar {
  width: 20px;
  height: 20px;
  border-radius: 50%;
  object-fit: cover;
}
.shop-name {
  font-weight: 500;
}
</style>