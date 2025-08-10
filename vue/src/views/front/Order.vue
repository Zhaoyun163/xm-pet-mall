<template>

  <div class="container">
    <div class="card" style="margin-bottom: 5px">
      <el-input v-model="data.name" style="width: 300px;margin-right: 10px" placeholder="请输入订单名称搜索" prefix-icon="Search"></el-input>
      <el-button type="primary" @click="load" plain>查询</el-button>
      <el-button type="success" @click="reset" plain>重置</el-button>
    </div>
    <div class="card" style="margin-bottom: 5px">
<!--      <el-button type="primary" @click="handleAdd" v-if="data.user.role === 'PETSHOP'" plain>新增</el-button>-->
      <el-button type="danger" @click="delBatch" plain>批量取消</el-button>

    </div>

    <div class="card" style="margin-bottom: 5px">
      <el-table :data="data.tableData" stripe @selection-change="handleSelectionChange" tooltip-effect="dark myTooltip">
        <el-table-column
            type="selection"
            width="55"
            :selectable="row => row.status === '未发货'"
        />        <el-table-column show-overflow-tooltip prop="orderNo" label="订单编号"></el-table-column>
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

        <el-table-column label="取消订单">
          <template #default="scope">
            <el-button
                type="danger"
                size="small"
                :icon="Delete"
                v-if="scope.row.status === '未发货'"
                circle @click="del(scope.row.id)"></el-button>
          </template>
        </el-table-column>

        <el-table-column label="收货">
          <template #default="scope">
            <!-- 只有"未发货"的订单才显示发货按钮 -->
            <el-button
                v-if="scope.row.status === '已发货'"
                type="success"
                size="small"
                :icon="Promotion"
                circle
                @click="receive(scope.row)" ><!-- 传递当前行数据 -->
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
import {Delete, Promotion} from "@element-plus/icons-vue";
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
  userList:[],
  content: null,
  viewVisible: false,


})

// 获取宠物店列表
request.get('/petShop/selectAll').then(res => {
  data.shopList = res.data
})

// 获取宠物类型列表
request.get('/user/selectAll').then(res => {
  // 将请求响应数据赋值给data中的typeList
  data.userList = res.data;


})


const view = (content) => {
  data.content = content
  data.viewVisible = true
}


// 分页加载数据
const load = () => {
  request.get('/order/selectPage', {
    params: {
      pageNum: data.pageNum,
      pageSize: data.pageSize,
      name: data.name,
      userId: data.user.id,
    }
  }).then(res => {
    // 更新表格数据，通过映射远程获取的列表信息，并 enriched 数据
    data.tableData = res.data.list;
    console.log(data.tableData);
    data.total = res.data.total;
  });
}

load()
// 重置

const reset = () => {
  data.name = null
  load()
}


// 删除
const del = (id) => {
  ElMessageBox.confirm('确认取消该订单吗？','取消确认', {type: 'warning'}).then(() => {
    request.delete('/order/deleteById/' + id).then(res => {
      if (res.code === '200') {
        ElMessage.success('删除成功')
        load()
      } else {
        ElMessage.error(res.msg)
      }
    })
  }).catch(() => {
    console.log('取消删除')
  })
}

// 收货
const receive = (row) => { // 接收当前行数据作为参数
  ElMessageBox.confirm('确认收货该订单吗？', '提示', {
    confirmButtonText: '确认',
    cancelButtonText: '取消',
    type: 'warning', // 更明显的警告样式
  }).then(() => {
    // 调用接口更新订单状态为"已发货"
    request.put('/order/update', {
      id: row.id, // 订单ID（必须传递）
      status: '已收货' // 新状态
    }).then(res => {
      if (res.code === '200') {
        ElMessage.success('收货成功');
        load(); // 刷新列表数据
      } else {
        ElMessage.error(res.msg || '收货失败');
      }
    });
  }).catch(() => {
    ElMessage.info('已取消收货');
  });
};


const handleSelectionChange = (rows) => {

  console.log(rows)
  data.ids = rows.map(row => row.id)
  console.log(data.ids)
}


////批量删除
const delBatch = () => {
  if (data.ids.length === 0) {
    ElMessage.warning('请选择要删除的数据')
    return
  }
  ElMessageBox.confirm('确认删除该员工信息吗？', '删除确认', {type: 'warning'}).then(() => {
    request.delete('/order/deleteBatch', {data: data.ids}).then(res => {
      if (res.code === '200') {
        ElMessage.success('删除成功')
        load()
      } else {
        ElMessage.error(res.msg)
      }
    })
  }).catch(() => {
    console.log('取消删除')
  })

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