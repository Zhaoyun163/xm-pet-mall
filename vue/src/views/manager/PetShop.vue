<template>
  <div>
    <div class="card" style="margin-bottom: 5px">
      <el-input v-model="data.name" style="width: 300px;margin-right: 10px" placeholder="请输入搜索名称" prefix-icon="Search"></el-input>
      <el-button type="primary" @click="load" plain>查询</el-button>
      <el-button type="success" @click="reset" plain>重置</el-button>
    </div>
    <div class="card" style="margin-bottom: 5px">
      <el-button type="primary" @click="handleAdd" plain>新增</el-button>
      <el-button type="danger" @click="delBatch" plain>批量删除</el-button>
    </div>

    <div class="card" style="margin-bottom: 5px">
      <el-table 
        tooltip-effect="dark myTooltip" 
        :data="data.tableData" 
        stripe 
        @selection-change="handleSelectionChange"
        :cell-style="{ padding: '5px' }"
      >
        <el-table-column type="selection" width="55" > </el-table-column>
        <el-table-column label="账号" prop="username"> </el-table-column>
        <el-table-column label="名称" prop="name"> </el-table-column>
        <el-table-column label="密码" prop="password"> </el-table-column>
        <el-table-column label="头像" prop="avatar">
          <template #default="scope">
            <el-image v-if="scope.row.avatar" preview-teleported="true" :preview-src-list="[scope.row.avatar]" :src="scope.row.avatar" style="display: block; width: 40px;height: 40px;border-radius: 50%" />
          </template>
        </el-table-column>
        <el-table-column label="手机号" prop="phone"> </el-table-column>
        <el-table-column label="邮箱" prop="email" show-overflow-tooltip> </el-table-column>
        <el-table-column label="销售宠物" prop="sellPet" show-overflow-tooltip>
          <template #default="scope">
            <el-tag show-overflow-tooltip style="margin-bottom: 4px" type="primary" v-for="item in JSON.parse(scope.row.sellPet || '[]')" :key="item">  <!--标签展示-->
              {{item}}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column label="地址" prop="address" show-overflow-tooltip > </el-table-column>
        <el-table-column label="介绍" show-overflow-tooltip prop="introduce"> </el-table-column>
        <el-table-column label="角色" prop="role"> </el-table-column>
        <el-table-column label="认证图片" prop="practiceLicense">
          <template #default="scope">
            <el-image v-if="scope.row.practiceLicense" preview-teleported="true" :preview-src-list="[scope.row.practiceLicense]" :src="scope.row.practiceLicense" style="display: block; width: 45px;height: 30px"/>
          </template>
        </el-table-column>
        <el-table-column label="负责人名称" prop="principalName"> </el-table-column>
        <el-table-column label="负责人身份证号" show-overflow-tooltip prop="principalNo"> </el-table-column>
        <el-table-column label="认证状态" prop="status">
          <template v-slot="scope">
            <el-tag type="info" v-if="scope.row.status === '待提交'">待提交</el-tag>
            <el-tag type="warning" v-if="scope.row.status === '待审核'">待审核</el-tag>
            <el-tag type="success" v-if="scope.row.status === '审核成功'">审核成功</el-tag>
            <el-tag type="danger" v-if="scope.row.status === '审核失败'">审核失败</el-tag>
          </template>
        </el-table-column>

        <el-table-column label="操作" width="280" fixed="right">
          <template #default="scope">
            <el-button v-if="scope.row.status === '待审核'" type="primary" plain size="small" @click="audit(scope.row, '审核成功')">通过</el-button>
            <el-button v-if="scope.row.status === '待审核'" type="danger" plain size="small" @click="audit(scope.row, '审核失败')">拒绝</el-button>
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
    <el-dialog title="宠物店主信息" v-model="data.formVisible" width="500px" destroy-on-close>
      <el-form ref="formRef" :rules="data.rules" :model="data.form" label-width="80px" style="margin-top: 20px;margin-right: 50px">
          <el-form-item label="账号:" prop="username">
            <el-input v-model="data.form.username" placeholder="请输入账号" autocomplete="off"></el-input>
          </el-form-item>
          <el-form-item label="名称:" prop="name">
            <el-input v-model="data.form.name" placeholder="请输入名称" autocomplete="off"></el-input>
          </el-form-item>
        <el-form-item label="头像:">
          <el-upload
              action="http://localhost:8080/files/upload"
              :on-success="handleAvatarSuccess"
              list-type="picture"
          >
            <el-button type="primary">上传头像</el-button>
          </el-upload> <!--上传头像-->
        </el-form-item>
          <el-form-item label="手机号:" prop="phone">
            <el-input v-model="data.form.phone" placeholder="请输入手机号" autocomplete="off"></el-input>
          </el-form-item>
          <el-form-item label="邮箱:" prop="email">
            <el-input v-model="data.form.email" placeholder="请输入邮箱" autocomplete="off"></el-input>
          </el-form-item>
          <el-form-item label="销售宠物:" prop="sellPet">
            <el-select multiple style="width: 100%" v-model="data.sellPet">
              <el-option v-for="item in data.petTypeList" :key="item.id" :value="item.name" :label="item.name"></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="地址:" prop="address">
            <el-input type="textarea" :rows="1" v-model="data.form.address" placeholder="请输入地址" autocomplete="off"></el-input>
          </el-form-item>
          <el-form-item label="介绍:" prop="introduce">
            <el-input type="textarea" :rows="2" v-model="data.form.introduce" placeholder="请输入介绍" autocomplete="off"></el-input>
          </el-form-item>
          <el-form-item label="角色:" prop="role">
            <el-input readonly v-model="data.form.role" placeholder="请输入角色" autocomplete="off"></el-input>
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
import * as JOSN from "postcss";

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
  sellPet:[],
  petTypeList:[],

})

const handleAvatarSuccess = (res, file) => {
  data.form.avatar = res.data
}

request.get('/petType/selectAll').then(res => {
  data.petTypeList = res.data
})

//分页加载数据
const load = () => {
  request.get('/petShop/selectPage', {
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
  data.form = {role:'PETSHOP'}
}
// 保存
const save = () => {   //两个操作，新增和修改，都使用save方法
  //将json数组转化为字符串
  data.form.sellPet = JSON.stringify(data.sellPet)
  data.form.id ? update() : add()
}

// 新增
const add= () => {
  request.post('/petShop/add', data.form).then(res => {
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
  request.put('/petShop/update', data.form).then(res => {
    if (res.code === '200') {
      data.formVisible = false
      ElMessage.success('保存成功')
      load()
    } else {
      ElMessage.error(res.msg)
    }
  })
}

// 审核
const audit = (row, status) => {
  ElMessageBox.confirm('确认'+ status + '该宠物店主信息吗？','审核确认', {type: 'warning'}).then(() => {
    let form = JSON.parse(JSON.stringify(row))
    form.status = status
    request.put('/petShop/update',  form).then(res => {
      if (res.code === '200') {
        ElMessage.success('操作成功')
        load()
      } else {
        ElMessage.error(res.msg)
      }
    })
  }).catch()

}

//编辑
const handleUpdate = (row) => {
  data.formVisible = true
  data.sellPet = JSON.stringify(data.form.sellPet)
  data.form = JSON.parse(JSON.stringify(row))  // 深拷贝一个对象，不会影响原对象
}

// 删除
const del = (id) => {
  ElMessageBox.confirm('确认删除该部门信息吗？','删除确认', {type: 'warning'}).then(() => {
    request.delete('/petShop/deleteById/' + id).then(res => {
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

//批量删除
const delBatch = () => {
  if (data.ids.length === 0) {
    ElMessage.warning('请选择要删除的数据')
    return
  }
  ElMessageBox.confirm('确认删除该部门信息吗？','删除确认', {type: 'warning'}).then(() => {
    request.delete('/petShop/deleteBatch', {data: data.ids}).then(res => {
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
/* 自定义表格单元格样式 */
.el-table .cell {
  padding: 5px !important; /* 调整单元格内边距 */
}

.myTooltip {
  max-width: 40% !important;
}
</style>