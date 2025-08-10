<template>
  <div class="container">
    <div class="card" style="margin-bottom: 5px">
      <el-input v-model="data.goodsName" style="width: 200px;margin-right: 10px" placeholder="请输入宠物商品名称搜索" prefix-icon="Search"></el-input>
      <el-input v-model="data.shopName" style="width: 200px;margin-right: 10px" placeholder="请输入宠物店名称搜索" prefix-icon="Search"></el-input>
      <el-button type="primary" @click="load" plain>查询</el-button>
      <el-button type="success" @click="reset" plain>重置</el-button>
    </div>
    <div class="card" style="margin-bottom: 5px">
      <el-button type="danger" @click="delBatch" plain>批量移除</el-button>
      <!--      <el-button type="info" >导入</el-button>-->
      <!--      <el-button type="success" >导出</el-button>-->
    </div>

    <div class="card" style="margin-bottom: 5px">
      <el-table :data="data.tableData" stripe @selection-change="handleSelectionChange" tooltip-effect="dark myTooltip">
        <el-table-column type="selection" width="55" > </el-table-column>
        <el-table-column prop="img" label="商品图片">
          <template #default="scope">
            <el-image style="width: 50px; height: 50px; border-radius: 5px" :src="scope.row.img" :preview-src-list="[scope.row.img]" preview-teleported></el-image>
          </template>
        </el-table-column>
        <el-table-column show-overflow-tooltip prop="shopName" label="宠物店"></el-table-column>
        <el-table-column show-overflow-tooltip prop="goodsName" label="商品名称"></el-table-column>
        <el-table-column prop="typeName" label="商品类型"></el-table-column>
        <el-table-column prop="quantity" label="数量">
          <template #default="scope">
            <el-input-number
                size="small"
                style="width: 90px;"
                v-model="scope.row.quantity"
                :min="1"
                @change="handleQuantityChange(scope.row)"> <!-- 数量变化时触发 -->
            </el-input-number>
          </template>
        </el-table-column>

        <el-table-column prop="totalPrice" label="总价"></el-table-column> <!-- 自动显示更新后的 totalPrice -->

        <el-table-column show-overflow-tooltip prop="formattedAddedAt" label="时间"></el-table-column>

        <el-table-column label="移除">
          <template #default="scope">
            <el-button type="danger" size="small" :icon="Delete" circle @click="del(scope.row.id)"></el-button>
          </template>
        </el-table-column>

        <el-table-column label="下单">
          <template #default="scope">
            <el-button type="success" size="small" :icon="Checked" circle @click="orderAdd(scope.row)"></el-button>
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
import {Delete,Checked} from "@element-plus/icons-vue";
import {reactive,} from "vue";
import request from "@/utils/request.js";
import {ElMessage, ElMessageBox} from "element-plus";


const data = reactive({
  goodsName:'',
  shopName:'',
  ids:[],
  form:{},
  user:JSON.parse(localStorage.getItem('xm-pet-mall-user')),
  tableData:[],
  goodsList:[],
  shopList:[],
  goodsTypeList:[],
  pageNum:1,
  pageSize:5,
  total:0,
});

// 下单
const orderAdd = (row) => {

  const generateOrderNo = () => {
    const timestamp = Date.now(); // 当前时间戳
    const randomNum = Math.floor(Math.random() * 1000); // 随机数（0-999）
    return `ORD-${timestamp}-${randomNum}`;
  };

  const orderNo = generateOrderNo(); // 调用函数生成订单编号

  request.post('/order/add', {
    orderNo: orderNo, // 新增订单编号字段
    name: row.goodsName,
    shopId:row.shopId,
    userId: row.userId,
    number: row.quantity,
    img:row.img,
    price:row.totalPrice,
    status:'未发货'


  }).then(res => {
    if (res.code === '200') {
      ElMessage.success('添加成功');
      load(); // 重新加载商品列表，或者你可以选择不重新加载，而是更新 quantityMap 中的对应值
    } else {
      ElMessage.error(res.msg);
    }
  });
};

request.get('/goods/selectAll').then(res =>{
  data.goodsList = res.data;
})

request.get('/petShop/selectAll').then(res =>{
  data.shopList = res.data;
})

request.get('/goodsType/selectAll').then(res => {
  data.goodsTypeList = res.data;
})

// 新增日期时间格式化函数（保持不变）
const formatDateTime = (dateTimeStr) => {
  if (!dateTimeStr) return '未知时间';

  const date = new Date(dateTimeStr);
  const year = date.getFullYear();
  const month = String(date.getMonth() + 1).padStart(2, '0');
  const day = String(date.getDate()).padStart(2, '0');
  const hours = String(date.getHours()).padStart(2, '0');
  const minutes = String(date.getMinutes()).padStart(2, '0');

  return `${year}-${month}-${day} ${hours}:${minutes}`;
};

// 分页加载数据
const load = () => {
  request.get('/shoppingCart/selectPage', {
    params: {
      pageNum: data.pageNum,
      pageSize: data.pageSize,
      userId: data.user.id,
      goodsName: data.goodsName,
      shopName: data.shopName,
    }
  }).then(res => {
    data.tableData = res.data.list.map(item => {
      // 初始化时计算 totalPrice
      const formattedTime = formatDateTime(item.addedAt);
      const totalPrice = (item.price * item.quantity).toFixed(2);

      return {
        ...item,
        totalPrice: totalPrice, // 初始化总价
        formattedAddedAt: formattedTime,
      };
    });
    console.log(data.tableData);
    data.total = res.data.total;
  });
};

// 新增：数量变化时重新计算总价
const handleQuantityChange = (row) => {
  // 确保 row.price 和 row.quantity 是有效数字
  const price = parseFloat(row.price) || 0;
  const quantity = parseInt(row.quantity) || 0;
  row.totalPrice = (price * quantity).toFixed(2); // 重新计算并更新
};
load()

// 重置
const reset = () => {
  data.goodsName = null
  data.shopName = null
  load()
}

//删除单条
const del = (id) => {
  ElMessageBox.confirm('确认移除该购物车信息吗？','移除确认', {type: 'warning'}).then(() => {
    request.delete('/shoppingCart/deleteById/' + id).then(res => {
      if (res.code === '200') {
        ElMessage.success('移除成功')
        load()
      } else {
        ElMessage.error(res.msg)
      }
    })
  }).catch(() => {
    console.log('取消移除')
  })
  load()
}

const handleSelectionChange = (rows) => {

  console.log(rows)
  data.ids = rows.map(row => row.id)
  console.log(data.ids)
}


//批量删除
const delBatch = () => {
  if (data.ids.length === 0) {
    ElMessage.warning('请选择要删除的数据')
    return
  }
  ElMessageBox.confirm('确认移除该购物车信息吗？', '移除确认', {type: 'warning'}).then(() => {
    request.delete('/shoppingCart/deleteBatch', {data: data.ids}).then(res => {
      if (res.code === '200') {
        ElMessage.success('移除成功')
        load()
      } else {
        ElMessage.error(res.msg)
      }
    })
  }).catch(() => {
    console.log('取消移除')
  })
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