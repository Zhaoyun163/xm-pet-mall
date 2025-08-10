<template>
  <div class="container">
    <div style="margin: 10px 10px; display: flex; justify-content: center; align-items: center">
      <div style="display: flex; gap: 10px; align-items: center;">
        <el-input
            v-model="data.name"
            style="width: 500px;"
            placeholder="请输入宠物店名称搜索"
            size="large"
            prefix-icon="Search">
        </el-input>
        <el-button type="primary" style="margin-left: 10px;" @click="load" plain>查询</el-button>
        <el-button type="success" @click="reset" plain>重置</el-button>
      </div>
    </div>

    <div>
      <div :data="data.petShopList" class="card" weight="100% " height="170px" style="display: flex;" v-for="item in data.petShopList" :key="item.id">
        <div style="flex: 1">
          <div style="display: flex;height: 170px;">
            <div style="flex: 1">
              <img :src="item.avatar" alt="" style="cursor: pointer; width: 150px; height:150px;display:
              block;border-radius: 10%;margin: 10px 10px" @click="router.push('/front/petShopDetail?id=' + item.id)">
            </div>
            <div style="flex: 1;margin-top: 20px;margin-right: 50px;height: 170px;">
              <div style="margin-bottom: 5px;font-size: 16px;font-weight: bold"><span style="color: #666;font-size: 14px;
              font-weight: normal;">宠物店名称：</span>{{item.name}}</div>
              <div style="margin-bottom: 5px"><span style="color: #666">宠物类别：</span>{{JSON.parse(item.sellPet || '[]').join('、')}}</div>
              <div style="margin-bottom: 5px"><span style="color: #666">联系方式：</span>{{item.phone}}</div>
              <div style="margin-bottom: 5px"><span style="color: #666">宠物店地址：</span>{{item.address}}</div>
            </div>
          </div>
        </div>

        <div style="flex: 1;margin-left: 20px;height: 150px;">
          <div style="display: flex">
            <div v-for="item1 in data.petList" :key="item1.id" class="pet-image-container">
              <img
                  v-if="item1.shopId === item.id"
                  :src="item1.img"
                  alt=""
                  class="pet-image"
                  @click="router.push('/front/petDetail?id=' + item1.id)"
                  style="flex:1;margin-top: 36px;margin-left: 10px"
              >
            </div>
          </div>
        </div>


      </div>

      <div style="margin-top: 10px">
        <el-pagination
            @size-change="load"
            @current-change="load"
            v-model:current-page="data.pageNum"
            v-model:page-size="data.pageSize"
            :page-sizes="[5, 10, 15, 20]"
            :background="background"
            layout="total, sizes, prev, pager, next, jumper"
            :total="data.total"
        />
      </div>

    </div>






  </div>
</template>

<script setup>
import { reactive ,ref} from 'vue'
import request from "@/utils/request.js";
import { onMounted } from 'vue';
import { useRoute } from 'vue-router';
import router from "@/router/index.js";

const data = reactive({
  form: {},
  petShopList:[],
  petList:[],
  name:null,
  pageNum:1,
  pageSize:5,
  total:0,

})

request.get('/petShop/selectAll').then(res => {
  data.petShopList = res.data;
})

request.get('/pet/selectAll',{
  params:{
    typeName:'',
  }
}).then(res =>{
  data.petList = res.data;
})

//分页加载数据
const load = () => {
  request.get('/petShop/selectPage', {
    params:{
      pageNum : data.pageNum,
      pageSize : data.pageSize,
      name : data.name,
    }
  }).then(res => {
    data.petShopList = res.data.list
    data.total = res.data.total
  })
}

const formRef = ref()

load()
// 重置

const reset = () => {
  data.name = null
  load()
}

</script>

<style scoped>
.container {
  width: 60%;
  margin: 0 auto;
  min-height: calc(100vh - 60px);
}

</style>

<style scoped>
.pet-image-container {
  display: flex;
  margin-bottom: 10px;
  gap: 5px;
  flex-wrap: wrap;
  max-width: 350px;
}

.pet-image {
  cursor: pointer;
  width: 100px;
  height: 100px;
  display: block;
  border-radius: 50%;
  object-fit: cover;
}
</style>
