<template>

  <div class="card">
    <div class="card" style="margin-bottom: 5px">
      <el-input v-model="data.name" style="width: 300px;margin-right: 10px" placeholder="请输入订单名称搜索" prefix-icon="Search"></el-input>
      <el-button type="primary" @click="load" plain>查询</el-button>
      <el-button type="success" @click="reset" plain>重置</el-button>
    </div>

    <div class="card" style="margin-bottom: 5px">
      <el-table :data="data.tableData" stripe @selection-change="handleSelectionChange" tooltip-effect="dark myTooltip">
        <el-table-column type="selection" width="55" > </el-table-column>
        <el-table-column show-overflow-tooltip prop="orderNo" label="订单编号"></el-table-column>
        <el-table-column prop="img" label="订单图片">
          <template #default="scope">
            <el-image style="width: 50px; height: 50px; border-radius: 5px" :src="scope.row.img" :preview-src-list="[scope.row.img]" preview-teleported></el-image>
          </template>
        </el-table-column>
        <el-table-column show-overflow-tooltip prop="name" label="订单名称"></el-table-column>
        <el-table-column prop="number" label="数量"></el-table-column>
        <el-table-column prop="shopName" label="宠物店"></el-table-column>

        <el-table-column prop="price" label="订单价格"></el-table-column>

        <el-table-column prop="status" label="订单状态">
          <template v-slot="scope">
            <el-tag type="danger" v-if="scope.row.status === '未发货'">未发货</el-tag>
            <el-tag type="primary" v-if="scope.row.status === '已发货'">已发货</el-tag>
            <el-tag type="success" v-if="scope.row.status === '已收货'">已收货</el-tag>
          </template>
        </el-table-column>

        <el-table-column label="发货">
          <template #default="scope">
            <!-- 只有"未发货"的订单才显示发货按钮 -->
            <el-button
                v-if="scope.row.status === '未发货'"
                type="success"
                size="small"
                :icon="Promotion"
                circle
                @click="delivery(scope.row)" ><!-- 传递当前行数据 -->
            </el-button>
          </template>
        </el-table-column>
      </el-table>

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
import {Promotion} from "@element-plus/icons-vue";
import {reactive} from "vue";
import request from "@/utils/request.js";
import {ElMessage, ElMessageBox} from "element-plus";

import '@wangeditor/editor/dist/css/style.css' // 引入样式

const data = reactive({
  user: JSON.parse(localStorage.getItem('xm-pet-mall-user')),
  name: null,
  tableData: [],
  pageNum:1,
  pageSize:5,
  total:0,
  formVisible:false,  // 确保 formVisible 初始化为 false
  form:{},
  ids:[],
  shopList:[],
  petShopList:[],
  content: null,
  viewVisible: false,


})

// 获取宠物店列表
request.get('/petShop/selectAll').then(res => {
  data.shopList = res.data
})

// 获取宠物类型列表
request.get('/petShop/selectAll').then(res => {
  // 将请求响应数据赋值给data中的typeList
  data.petShopList = res.data;


})

// 分页加载数据
const load = () => {
  request.get('/order/selectPage', {
    params: {
      pageNum: data.pageNum,
      pageSize: data.pageSize,
      name: data.name,
      shopId: data.user.role === 'PETSHOP' ? data.user.id : null // 新增：如果角色是 PETSHOP，则传递 shopId
    }
  }).then(res => {
    // 更新表格数据，通过映射远程获取的列表信息，并 enriched 数据
    data.tableData = res.data.list;
    data.total = res.data.total;
  });
}

load()
// 重置

const reset = () => {
  data.name = null
  load()
}


// 发货
const delivery = (row) => { // 接收当前行数据作为参数
  ElMessageBox.confirm('确认发货该订单吗？', '提示', {
    confirmButtonText: '确认',
    cancelButtonText: '取消',
    type: 'warning', // 更明显的警告样式
  }).then(() => {
    // 调用接口更新订单状态为"已发货"
    request.put('/order/update', {
      id: row.id, // 订单ID（必须传递）
      status: '已发货' // 新状态
    }).then(res => {
      if (res.code === '200') {
        ElMessage.success('发货成功');
        load(); // 刷新列表数据
      } else {
        ElMessage.error(res.msg || '发货失败');
      }
    });
  }).catch(() => {
    ElMessage.info('已取消发货');
  });
};


const handleSelectionChange = (rows) => {

  console.log(rows)
  data.ids = rows.map(row => row.id)
  console.log(data.ids)
}



</script>


<style>

.container {
  width: 60%;
  margin: 0 auto;
  min-height: calc(100vh - 60px);
}

.myTooltip {
  max-width: 40% !important;
}
</style>