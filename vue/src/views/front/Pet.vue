<template>
  <div class="container">
    <div style="margin: 10px 10px; display: flex; justify-content: center; align-items: center">
      <div style="display: flex; gap: 10px; align-items: center;">
        <div style="flex: 1">
          <div>
            <el-select
                v-model="data.typeName"
                placeholder="请选择销售类型"
                filterable
                size="large"
            >
              <el-option
                  v-for="item in data.petTypeList"
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
              style="width: 300px;"
              placeholder="请输入宠物名称搜索"
              size="large"
              prefix-icon="Search">
          </el-input>
        </div>
        <el-button type="primary" style="margin-left: 10px;" @click="load" plain>查询</el-button>
        <el-button type="success"  @click="reset" plain>重置</el-button>
      </div>
    </div>

    <div>
      <div class="card" weight="100% " height="170px" style="margin: 10px 10px;display: flex;">
        <div>
          <div class="pet-list">
            <div class="pet-item" v-for="item in data.petList" :key="item.id">
              <img :src="item.img" alt="" style="width: 100%; height: 200px; display: block; cursor: pointer" @click="router.push('/front/petDetail?id=' + item.id)">
              <div style="padding: 10px; display: flex;">
                <div style="font-size: 20px; font-weight: bold; flex: 1">{{ item.name }}</div>
                <div style="font-size: 20px; font-weight: bold; flex: 1; color: red; text-align: right; margin-right: 10px">$ {{ item.price }}</div>
              </div>
              <div style="padding:0 10px 10px;">
                <el-button type="primary" size="small" @click="orderAdd(item)">下单购买宠物</el-button>
              </div>
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
            :page-sizes="[8, 12, 16, 20]"
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
import router from "@/router/index.js";
import {ElMessage} from "element-plus";

const data = reactive({
  form: {},
  petList:[],
  petTypeList:[],
  name:null,
  typeName:'',
  pageNum:1,
  pageSize:8,
  total:0,

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


request.get('/pet/selectAll').then(res =>{
  data.petList = res.data;
})

request.get('/petType/selectAll').then(res => {
  data.petTypeList = res.data;
})

//分页加载数据
const load = () => {
  request.get('/pet/selectPage', {
    params:{
      pageNum : data.pageNum,
      pageSize : data.pageSize,
      name : data.name,
      // 如果typeName是数组，可能需要转换为字符串或根据后端要求处理
     typeName: data.typeName // 如果后端需要逗号分隔的字符串

    }
  }).then(res => {
    data.petList = res.data.list
    data.total = res.data.total
  })
}

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


