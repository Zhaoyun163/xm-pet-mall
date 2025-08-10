<template>

  <div>
    <div class="card" style="margin-bottom: 5px">
      <el-input v-model="data.name" style="width: 300px;margin-right: 10px" placeholder="请输入搜索类型" prefix-icon="Search"></el-input>
      <el-button type="primary" @click="load">查询</el-button>
      <el-button type="success" @click="reset">重置</el-button>
    </div>
    <div class="card" style="margin-bottom: 5px">
      <el-button type="primary" @click="handleAdd">新增</el-button>
      <el-button type="danger" @click="delBatch">批量删除</el-button>
    </div>

    <div class="card" style="margin-bottom: 5px">
      <el-table :data="data.tableData" stripe @selection-change="handleSelectionChange">
        <el-table-column type="selection" width="55" > </el-table-column>
        <el-table-column label="名字" prop="name">
        </el-table-column>
        <el-table-column label="操作">
          <template #default="scope">
            <el-button type="primary" size="small" :icon="Edit" circle @click="handleUpdate(scope.row)"></el-button>
            <el-button type="danger" size="small" :icon="Delete" circle @click="del(scope.row.id)"></el-button>
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

    <!--    //destroy-on-close 关闭弹窗时销毁组件-->
    <el-dialog title="宠物类型信息" v-model="data.formVisible" width="500px" destroy-on-close>
      <el-form ref="formRef" :rules="data.rules" :model="data.form" label-width="80px" style="margin-top: 20px;margin-right: 50px">
        <el-form-item label="类型:" prop="name">
          <el-input v-model="data.form.name" placeholder="请输入类型" autocomplete="off"></el-input>
        </el-form-item>
      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="save">保 存</el-button>
          <el-button @click="data.formVisible = false">取 消</el-button>
        </div>
      </template>
    </el-dialog>

  </div>
</template>


<script setup>

import { reactive,ref } from 'vue'
import {Delete, Edit, Search} from '@element-plus/icons-vue'
import request from "@/utils/request.js";
import {ElMessage, ElMessageBox} from "element-plus";

const data = reactive({
  name: null,
  tableData: [],
  pageNum:1,
  pageSize:5,
  total:0,
  formVisible:false,
  form:{},
  ids:[],
  rules: {
    name: [
      {required: true, message: '请输入类型', trigger: 'blur'}
    ],
  },

})



//分页加载数据
const load = () => {
  request.get('/goodsType/selectPage', {
    params:{
      pageNum : data.pageNum,
      pageSize : data.pageSize,
      name : data.name
    }
  }).then(res => {
    data.tableData = res.data.list
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

// 新增
const handleAdd = () => {
  data.formVisible = true
  data.form = {}
}
// 保存
const save = () => {   //两个操作，新增和修改，都使用save方法
  formRef.value.validate((valid)=>{    //表单验证
    if (valid) {
      data.form.id ? update() : add()
    }
  })
}

// 新增
const add= () => {
  request.post('/goodsType/add', data.form).then(res => {
    if (res.code === '200') {
      data.formVisible = false
      ElMessage.success('添加成功')
      load()
    } else {
      ElMessage.error(res.msg)
    }
  })
}

// 更新
const update= () => {
  request.put('/goodsType/update', data.form).then(res => {
    if (res.code === '200') {
      data.formVisible = false
      ElMessage.success('保存成功')
      load()
    } else {
      ElMessage.error(res.msg)
    }
  })
}

//编辑
const handleUpdate = (row) => {
  data.formVisible = true
  data.form = JSON.parse(JSON.stringify(row))  // 深拷贝一个对象，不会影响原对象
}

// 删除
const del = (id) => {
  ElMessageBox.confirm('确认删除该部门信息吗？','删除确认', {type: 'warning'}).then(() => {
    request.delete('/goodsType/deleteById/' + id).then(res => {
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


const handleSelectionChange = (rows) => {
  data.ids = rows.map(row => row.id)
}


////批量删除
const delBatch = () => {
  if (data.ids.length === 0) {
    ElMessage.warning('请选择要删除的数据')
    return
  }
  ElMessageBox.confirm('确认删除该部门信息吗？','删除确认', {type: 'warning'}).then(() => {
    request.delete('/goodsType/deleteBatch', {data: data.ids}).then(res => {
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