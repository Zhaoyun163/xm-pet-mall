<template>
  <div class="container">
    <div style="margin-bottom: 20px">
      <div> <!-- 轮播图 -->
        <el-carousel height="350px" w>
          <el-carousel-item v-for="item in data.slideshowList" :key="item">
            <img @click="goTO('/front/petDetail?id=' + item.petId)" :src="item.img" alt="" style="width: 100%; cursor: pointer">
          </el-carousel-item>
        </el-carousel>
      </div>
    </div>

    <div style="margin-bottom: 20px;display: flex;grid-gap: 20px">
      <div style="flex: 1">
        <div style="display: flex;align-items: center;margin-bottom: 10px">
          <div style="flex: 1;font-size:22px;font-weight: bold;text-align: left">推荐宠物</div>
          <div style="cursor: pointer" @click="router.push('/front/pet')">查看所有宠物<el-icon style="top:2px"><ArrowRight/></el-icon></div>
        </div>
        <div>  <!-- 推荐宠物列表 -->
          <el-row :gutter="10">
            <el-col :span="12" v-for="item in data.recommendPetList" :key="item.id">
              <div class="card" style="padding: 0;margin-bottom: 10px; cursor: pointer">
                <img :src="item.img" alt="" style="width: 100%; height:200px;display: block;" @click="goTO('/front/petDetail?id=' + item.id)">
                <div style="padding: 10px;display: flex;">
                  <div style="font-size: 20px;font-weight: bold;flex: 1">{{item.name}}</div>
                  <div style="font-size: 20px;font-weight: bold;flex: 1;color: red;text-align: right;margin-right: 10px">$ {{item.price}}</div>
                </div>
                <div style="padding:0 10px 10px;">
                  <el-button type="primary" size="small" @click="orderAdd(item)">下单购买宠物</el-button>
                </div>
              </div>
            </el-col>
          </el-row>
        </div>

      </div>

      <div style="flex: 1">
        <div style="display: flex;align-items: center;margin-bottom: 10px">
          <div style="flex: 1;font-size:22px;font-weight: bold;text-align: left">热门宠物店</div>
          <div style="cursor: pointer" @click="router.push('/front/petShop')">查看所有宠物店<el-icon style="top:2px"><ArrowRight/></el-icon></div>
        </div>
        <div class="card" style="padding:15px; ">
          <div class="petShop-item" v-for="item in data.petShopList" :key="item.id" style="display: flex;align-items: center;grid-gap: 25px;
            margin-bottom: 10px;border-bottom: 1px solid #eee;padding:10px 0" >
            <div style="width: 120px;text-align: center;margin-left: 5px;cursor: pointer;" @click="goTO('/front/petShopDetail?id=' + item.id)">
              <img :src="item.avatar" alt="" style="width: 45px; height:45px;border-radius: 50%">
              <div style="font-size: 16px">{{item.name}}</div>
            </div>
            <div style="width: 100%;">
              <div style="margin-bottom: 10px"><span style="color: #666">宠物店地址：</span>{{item.address}}</div>
              <div><span style="color: #666">宠物店售卖种类：</span>{{JSON.parse(item.sellPet || '[]').join('、')}}</div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div>
      <div style="display: flex;align-items: center;margin-bottom: 10px">
        <div style="flex: 1;font-size:22px;font-weight: bold;text-align: left">推荐商品</div>
        <div style="cursor: pointer" @click="router.push('/front/goods')">查看所有商品<el-icon style="top:2px"><ArrowRight/></el-icon></div>
      </div>
      <div>  <!-- 推荐商品列表 -->
        <el-row :gutter="10">
          <el-col :span="6" v-for="item in data.goodsList" :key="item.id">
            <div class="card" style="padding: 0;margin-bottom: 10px; ">
              <img :src="item.img" alt="" style="width: 100%; height:200px;display: block;">
              <div style="padding: 10px 10px 0 10px;display: flex;">
                <div style="flex: 1">
                  <el-tag type="success" v-if="item.status === '上架'">上架</el-tag>
                  <el-tag type="danger" v-if="item.status === '下架'">下架</el-tag>
                </div>
                <div style="font-size: 20px;font-weight: bold;margin-left:5px;white-space: nowrap; overflow: hidden; text-overflow: ellipsis;">{{item.name}}</div>
              </div>

              <div style="display: flex;padding: 10px 10px 0 10px;">
                <div style="font-size: 20px;font-weight: bold;flex: 1;color: red;margin-right: 10px">$ {{item.price}}</div>
                <div style="flex: 1;">
                  <el-button type="primary" size="small" @click="disc(item.id)" plain>查看详情</el-button>
                </div>
              </div>
              <div style="display: flex;padding: 10px 0 10px 10px;">
                <div style="flex: 1;">
                  <!-- 使用 quantityMap 来获取当前商品的数量 -->
                  <el-input-number
                      size="small"
                      style="width: 90px;"
                      min="1"
                      v-model="data.quantityMap[item.id]"
                      placeholder="请输入数量"
                      autocomplete="off">
                  </el-input-number>                </div>
                <div style="flex: 1;">
                  <el-button type="primary" size="small" @click="shop(item.id,item.typeId,data.quantityMap[item.id])">加入购物车</el-button>
                </div>
              </div>
            </div>
          </el-col>
        </el-row>
      </div>

    </div>

    <el-dialog title="宠物商品详情" v-model="data.formVisible" width="35%" >
      <div style="padding:20px">
        <div style="display: flex;align-items: center;justify-content: center;margin-bottom: 20px">
          <img :src="data.discGoods.img" alt="" style="width: 300px; height:300px;display: block;">
        </div>
        <div style="display: flex">
          <div style="flex: 1">
            <el-tag size="large" type="success" v-if="data.discGoods.status === '上架'">上架</el-tag>
            <el-tag size="large" type="danger" v-if="data.discGoods.status === '下架'">下架</el-tag>
          </div>
          <div style="font-size:20px;font-weight:bold;margin:0 10px 10px 10px">{{data.discGoods.name}}</div>
        </div>
        <div style="display: flex;color: black">
          <div style="flex: 1">
            <div style="margin-bottom: 10px; display: flex; align-items: center;">
              <span style="color: #666; margin-right: 8px;">宠物店：</span>
              <div style="display: flex; align-items: center;">
                <img :src="data.petShopAvatar" alt=""
                     style="cursor: pointer; width: 20px; height: 20px; border-radius: 50%; margin-right: 8px;"
                     @click="router.push('/front/petShopDetail?id='+ data.discGoods.shopId)">
                <span>{{data.petShopName}}</span>
              </div>
            </div>
          </div>
          <div style="margin-bottom: 10px;flex: 1"><span style="color: #666;">商品类型：</span>{{data.goodsTypeName}}</div>

        </div>

        <div style="margin-bottom: 10px;color: black"><span style="color: #666;">商品介绍：</span>{{data.discGoods.introduce}}</div>
        <div style="margin-bottom: 10px;color:red;font-size: 30px">
          <span style="color: #666;font-size: 14px">宠物价格：</span>${{data.discGoods.price}}
        </div>

      </div>
      <template #footer>
        <sapn class="dialog-footer">
          <el-button @click="data.formVisible = false">关 闭</el-button>
        </sapn>
      </template>
    </el-dialog>


  </div>
</template>

<script setup>
import { reactive } from 'vue'
import request from "@/utils/request.js";
import router from "@/router/index.js";
import {ElMessage} from "element-plus";

const data = reactive({
  user:JSON.parse(localStorage.getItem('xm-pet-mall-user')),
  quantityMap:[],
  slideshowList:[],
  recommendPetList:[],
  petShopList:[],
  goodsList:[],
  formVisible:false,
  discGoods:{},
  number:1,
  petShopName:'',
  goodsTypeName:'',
  petShopAvatar:'',
})


// 下单
const orderAdd = (item) => {

  const generateOrderNo = () => {
    const timestamp = Date.now(); // 当前时间戳
    const randomNum = Math.floor(Math.random() * 1000); // 随机数（0-999）
    return `ORD-${timestamp}-${randomNum}`;
  };

  const orderNo = generateOrderNo(); // 调用函数生成订单编号

  request.post('/order/add', {
    status:'未发货',
    orderNo: orderNo, // 新增订单编号字段
    name: item.name,
    shopId:item.shopId,
    userId: item.userId,
    number: 1,
    img:item.img,
    price:item.price,


  }).then(res => {
    if (res.code === '200') {
      ElMessage.success('添加成功');
      load(); // 重新加载商品列表，或者你可以选择不重新加载，而是更新 quantityMap 中的对应值
    } else {
      ElMessage.error(res.msg);
    }
  });
};

//宠物商品详情
const disc = (id) => {
  data.formVisible = true  // 确保 formVisible 设置为 true
  request.get('/goods/selectById/'+ id,{
    params:{
      typeName:''
    }
  }).then(res => {
    data.discGoods = res.data

    request.get('/goodsType/selectById/'+ data.discGoods.typeId).then(res =>{
      data.goodsTypeName = res.data.name
    })

    request.get('/petShop/selectById/'+ data.discGoods.shopId).then(res =>{
      data.petShopName = res.data.name;
      data.petShopAvatar = res.data.avatar;
    })

  })
}

//订单方法
const shop = (id, typeId, quantity) => {
  request.post('/shoppingCart/add', {
    goodsId: id,
    typeId: typeId,
    quantity: quantity,
    userId: data.user.id
  }).then(res => {
    if (res.code === '200') {
      ElMessage.success('添加成功');
      load(); // 重新加载商品列表，或者你可以选择不重新加载，而是更新 quantityMap 中的对应值
    } else {
      ElMessage.error(res.msg);
    }
    console.log(quantity)
  });
};


request.get('/slideshow/selectAll').then(res => {
  data.slideshowList = res.data
})

request.get('/goods/selectAll',{
  params:{
    typeName:'',
  }
}).then(res => {
  data.goodsList = res.data.splice(0,8);
  // 初始化 quantityMap，为每个商品设置默认数量为 1
  data.goodsList.forEach(item => {
    if (!data.quantityMap[item.id]) {
      data.quantityMap[item.id] = 1;
    }
  });
})

request.get('/petShop/selectAll',{
  params:{
    status:'审核成功'
  }
}).then(res => {
  data.petShopList = res.data.splice(0,6)
})

request.get('/pet/selectAll',{
  params:{
    recommend:'是',
    status:'上架',
    typeName:''
  }
}).then(res => {
  data.recommendPetList = res.data.splice(0,4)
})

const goTO = (path) => {
  router.push(path)
}
</script>

<style scoped>
.container {
  width: 60%;
  margin: 0 auto;
  min-height: calc(100vh - 60px);
}

.petShop-item:last-child{
  border: none !important;
  padding-bottom: 0 !important;
}
</style>