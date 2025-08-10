<template>
  <div class="container">
    <div class="card" style="align-items: center;margin: 20px 0">
      <div style="display: flex">
        <div style="flex:1;padding: 0;margin: 10px 10px;">
          <img :src="data.form.avatar" alt="" style="width: 400px; height:400px;display: block;border-radius: 20px">
        </div>
        <div  :v-if="Object.keys(data.form).length > 0" style="flex:1;padding: 0;margin: 10px 10px;">
          <div style="font-size: 25px;font-weight: bold;margin-bottom: 10px">{{data.form.name}}</div>

          <div style="margin-bottom: 10px"><span style="color: #666">宠物类别：</span>{{JSON.parse(data.form.sellPet || '[]').join('、')}}</div>
          <div style="margin-bottom: 10px"><span style="color: #666">联系方式：</span>{{data.form.phone}}</div>
          <div style="margin-bottom: 10px"><span style="color: #666">宠物店地址：</span>{{data.form.address}}</div>
          <div style="margin-bottom: 10px"><span style="color: #666">宠物店介绍：</span>{{data.form.introduce}}</div>

          <el-button type="primary"  @click="router.push('/front/home')">返回首页</el-button>

        </div>
      </div>
    </div>

    <div class="card" style="align-items: center;">
      <div style="font-size: 25px;font-weight: bold;margin:10px 10px;text-align: center">售卖宠物</div>
      <div style=" border-bottom: 2px solid #eee;margin: 20px 10px;"></div>
      <div>  <!-- 宠物列表 -->
        <el-row :gutter="6"><!-- 宠物列表栅格布局容器 :gutter 6 - 设置栅格间隔为6像素 采用24分栏布局系统，每行展示4个元素（每个占6分栏） -->
          <el-col :span="8" v-for="item in data.petList" :key="item.id">
            <!-- 宠物信息卡片列  :span 6 - 每个列占据6/24的宽度（约25%） v-for 遍历data.petList生成列 :key 使用item.id作为唯一标识 -->
            <div class="card" style="padding: 0;margin-bottom: 10px;">
              <img :src="item.img" alt="" style="width: 100%; height:250px;display: block; cursor: pointer" @click="router.push('/front/petDetail?id=' + item.id)">
              <div style="padding: 10px;display: flex;">
                <div style="font-size: 18px;font-weight: bold;flex: 1;">{{item.name}}</div>
                <div style="font-size: 18px;font-weight: bold;flex: 1;color: red;text-align: right;margin-right: 10px">$ {{item.price}}</div>
              </div>
              <div style="padding:0 10px 10px;">
                <el-button type="primary" size="small" @click="orderAdd(item)">下单购买宠物</el-button>
              </div>
            </div>
          </el-col>
        </el-row>
      </div>

    </div>

    <div class="card" style="align-items: center;">
      <div style="font-size: 25px;font-weight: bold;margin:10px 10px;text-align: center">售卖商品</div>
      <div style=" border-bottom: 2px solid #eee;margin: 20px 10px;"></div>
      <div>
        <el-row :gutter="6">
          <el-col :span="8" v-for="item in data.goodsList" :key="item.id">
            <div class="card" style="padding: 0;margin-bottom: 10px; ">
              <img :src="item.img" alt="" style="width: 100%; height:300px;display: block;">
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
                  </el-input-number>                  </div>
                <div style="flex: 1;">
                  <el-button type="danger" size="small" @click="shop(item.id,item.typeId,data.quantityMap[item.id])">加入购物车</el-button>
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
import { onMounted } from 'vue';
import { useRoute } from 'vue-router';
import router from "@/router/index.js";
import {ElMessage} from "element-plus";

const data = reactive({
  user:JSON.parse(localStorage.getItem('xm-pet-mall-user')),
  form:{},
  petList:[],
  goodsList:[],
  quantityMap: {},
  formVisible:false,
  discGoods:{},
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

// 加入购物车
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

const route = useRoute();

onMounted(() => {
  // 从路由中获取查询参数
  const id = route.query.id;
  // 请求数据
  request.get('/petShop/selectById/'+id).then(res => {
    // res.data是一个数组，数组的第一个元素是当前宠物店的详情数据
    data.form = res.data;

    // 宠物店id查询宠物
    request.get('/pet/selectAll',{
      params:{
        shopId:data.form.id,
        typeName:''
      }

    }).then(res => {
      data.petList = res.data

    })

    request.get('/goods/selectAll',{
      params:{
        shopId:data.form.id,
        typeName:''
      }

    }).then(res => {
      data.goodsList = res.data

    })
    request.get('/goods/selectPage', {
      params: {
        shopId:data.form.id,
        typeName: ''
      }
    }).then(res => {
      data.goodsList = res.data.list;
      // 初始化 quantityMap，为每个商品设置默认数量为 1
      data.goodsList.forEach(item => {
        if (!data.quantityMap[item.id]) {
          data.quantityMap[item.id] = 1;
        }
      });
    });


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