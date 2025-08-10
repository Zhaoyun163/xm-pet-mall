<template>
  <div class="container">
    <div style="margin: 10px 10px; display: flex; justify-content: center; align-items: center">
      <div style="display: flex; gap: 10px; align-items: center;">
        <div style="flex: 1">
          <div>
            <el-select
                v-model="data.typeName"
                placeholder="请选择商品类型"
                filterable
                size="large"
            >
              <el-option
                  v-for="item in data.goodsTypeList"
                  :key="item.id"
                  :value="item.name"
                  :label="item.name"
              ></el-option>
            </el-select>
          </div>

        </div>
        <div style="flex: 1">
          <el-input
              v-model="data.name"
              style="width: 300px;font-size: 18px"
              placeholder="请输入宠物名称搜索"
              size="large"
              prefix-icon="Search">
          </el-input>
        </div>
        <el-button type="primary" style="font-size: 18px;margin-left: 10px;" @click="load" plain>查询</el-button>
        <el-button type="success" style="font-size: 18px" @click="reset" plain>重置</el-button>
      </div>
    </div>

    <div>
      <div class="card" weight="100% " height="170px" style="margin: 10px 10px;display: flex;">
        <div>
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
                    </el-input-number>
                  </div>
                  <div style="flex: 1;">
                    <el-button type="danger" size="small" @click="shop(item.id,item.typeId,data.quantityMap[item.id])">加入购物车</el-button>
                  </div>
                </div>
              </div>
            </el-col>
          </el-row>
        </div>

      </div>

      <div style="margin-top: 10px">
        <el-pagination
            @size-change="load"
            @current-change="load"
            v-model:current-page="data.pageNum"
            v-model:page-size="data.pageSize"
            :page-sizes="[8, 12, 16, 20]"
            :background="background"
            layout="total, sizes, prev, pager, next, jumper"
            :total="data.total"
        />
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
import { reactive ,ref} from 'vue'
import request from "@/utils/request.js";
import { onMounted } from 'vue';
import { useRoute } from 'vue-router';
import router from "@/router/index.js";
import user from "@/views/manager/User.vue";
import {ElMessage} from "element-plus";

const data = reactive({
  user:JSON.parse(localStorage.getItem('xm-pet-mall-user')),
  form: {},
  quantityMap: {},
  goodsList:[],
  goodsTypeList:[],
  name:null,
  typeName:'',
  pageNum:1,
  pageSize:8,
  total:0,
  number:1,
  formVisible:false,
  discGoods:{},
  petShopName:'',
  goodsTypeName:'',
  petShopAvatar:'',

})

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

request.get('/goods/selectAll').then(res =>{
  data.goodsList = res.data;
})

request.get('/goodsType/selectAll').then(res => {
  data.goodsTypeList = res.data;
})

//分页加载数据
const load = () => {
  request.get('/goods/selectPage', {
    params: {
      pageNum: data.pageNum,
      pageSize: data.pageSize,
      name: data.name,
      typeName: data.typeName
    }
  }).then(res => {
    data.goodsList = res.data.list;
    data.total = res.data.total;
    // 初始化 quantityMap，为每个商品设置默认数量为 1
    data.goodsList.forEach(item => {
      if (!data.quantityMap[item.id]) {
        data.quantityMap[item.id] = 1;
      }
    });
  });
};

const formRef = ref()

load()
// 重置

const reset = () => {
  data.name = null
  data.typeName = ''
  load()
}

</script>

<style scoped>
.container {
  width: 60%;
  margin: 0 auto;
  min-height: calc(100vh - 60px);
}

.custom-select {
  height: 50px !important;
  font-size: 18px !important;
}


</style>

<style scoped>
.pet-list {
  display: flex;
  flex-wrap: wrap;
  gap: 10px; /* 调整项目之间的间距 */
}

.pet-item {
  flex: 1 1 calc(25% - 10px); /* 调整每个项目的宽度，这里设置为 25% 减去间距 */
  box-sizing: border-box;
  border: 1px solid #dfdfdf;
  border-radius: 4px;
}

/* 响应式调整 */
@media (max-width: 1200px) {
  .pet-item {
    flex: 1 1 calc(33.33% - 10px);
  }
}

@media (max-width: 992px) {
  .pet-item {
    flex: 1 1 calc(50% - 10px);
  }
}

@media (max-width: 768px) {
  .pet-item {
    flex: 1 1 100%;
  }
}
</style>


