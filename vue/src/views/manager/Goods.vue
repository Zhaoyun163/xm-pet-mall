<template>

  <div>
    <div class="card" style="margin-bottom: 5px">
      <el-input v-model="data.name" style="width: 300px;margin-right: 10px" placeholder="请输入宠物商品名称搜索" prefix-icon="Search"></el-input>
      <el-button type="primary" @click="load" plain>查询</el-button>
      <el-button type="success" @click="reset" plain>重置</el-button>
    </div>
    <div class="card" style="margin-bottom: 5px">
      <el-button type="primary" @click="handleAdd" v-if="data.user.role === 'PETSHOP'" plain>新增</el-button>
      <el-button type="danger" @click="delBatch" plain>批量删除</el-button>
    </div>

    <div class="card" style="margin-bottom: 5px">
      <el-table :data="data.tableData" stripe @selection-change="handleSelectionChange" tooltip-effect="dark myTooltip" v-if="data.user.role === 'ADM' || data.user.role === 'PETSHOP'">
        <el-table-column type="selection" width="55" > </el-table-column>
        <el-table-column prop="shopName" label="商品宠物店"></el-table-column>
        <el-table-column prop="typeName" label="商品类型"></el-table-column>
        <el-table-column prop="name" show-overflow-tooltip label="商品名称"></el-table-column>
        <el-table-column prop="img" label="商品图片">
          <template #default="scope">
            <el-image style="width: 50px; height: 50px; border-radius: 5px" :src="scope.row.img" :preview-src-list="[scope.row.img]" preview-teleported></el-image>
          </template>
        </el-table-column>
        <el-table-column prop="price" label="商品价格"></el-table-column>
        <el-table-column prop="introduce" show-overflow-tooltip label="商品介绍"></el-table-column>
        <el-table-column prop="status" label="商品状态">
          <template v-slot="scope">
            <el-tag type="success" v-if="scope.row.status === '上架'">上架</el-tag>
            <el-tag type="danger" v-if="scope.row.status === '下架'">下架</el-tag>
          </template>
        </el-table-column>

        <el-table-column label="操作">
          <template #default="scope">
            <el-button type="primary" size="small" v-if="data.user.role === 'PETSHOP'" :icon="Edit" circle @click="handleUpdate(scope.row)"></el-button>
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
    <el-dialog title="商品信息" v-model="data.formVisible" width="50%" destroy-on-close>
      <el-form ref="formRef" :rules="data.rules" :model="data.form" label-width="80px" style="margin-top: 20px;margin-right: 50px">
        <el-form-item prop="shopId" label="商品宠物店">
          <el-select disabled style="width: 100%" v-model="data.form.shopId">
            <el-option v-for="item in data.shopList" :key="item.id" :value="item.id" :label="item.name"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item prop="typeId" label="商品类型">
          <el-select style="width: 100%" v-model="data.form.typeId">
            <el-option v-for="item in data.typeList" :key="item.id" :value="item.id" :label="item.name"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item prop="name" label="商品名称">
          <el-input v-model="data.form.name" placeholder="请输入商品名称"></el-input>
        </el-form-item>
        <el-form-item prop="img" label="商品图片">
          <el-form-item>
            <el-upload
                action="http://localhost:8080/files/upload"
                :on-success="handleAvatarSuccess"
                list-type="picture"
            >
              <el-button type="primary">上传图片</el-button>
            </el-upload>   <!--上传图片-->
          </el-form-item>
        </el-form-item>
        <el-form-item prop="price" label="商品价格">
          <el-input-number :min="1" style="width: 200px" step="10" v-model="data.form.price" placeholder="请输入宠物价格"></el-input-number>
        </el-form-item>
        <el-form-item prop="status" label="商品状态">
          <el-radio-group v-model="data.form.status">
            <el-radio-button type="success" label="上架">上架</el-radio-button>
            <el-radio-button type="danger" label="下架">下架</el-radio-button>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="商品介绍:" prop="introduce">
          <el-input type="textarea" :rows="2" v-model="data.form.introduce" placeholder="请输入介绍" autocomplete="off"></el-input>
        </el-form-item>


      </el-form>
      <template #footer>
        <div class="dialog-footer">
          <el-button type="primary" @click="save">保 存</el-button>
          <el-button @click="data.formVisible = false">取 消</el-button>
        </div>
      </template>
    </el-dialog>

    <el-dialog title="商品详情" v-model="data.viewVisible" width="50%" :close-on-click-modal="false">
      <div>
        {{data.form.name}}的详细信息：
      </div>
      <template #footer>
        <sapn class="dialog-footer">
          <el-button @click="data.viewVisible = false">关 闭</el-button>
        </sapn>
      </template>
    </el-dialog>

  </div>

</template>

<script setup>
import {Delete, Edit} from "@element-plus/icons-vue";
import {reactive} from "vue";
import request from "@/utils/request.js";
import {ElMessage, ElMessageBox} from "element-plus";

import '@wangeditor/editor/dist/css/style.css' // 引入样式
import {onBeforeUnmount,ref,shallowRef} from "vue";
import {Editor,Toolbar } from '@wangeditor/editor-for-vue'

const data = reactive({
  user: JSON.parse(localStorage.getItem('xm-pet-mall-user')),
  name: null,
  tableData:[],
  pageNum:1,
  pageSize:5,
  total:0,
  formVisible:false,  // 确保 formVisible 初始化为 false
  form:{},
  ids:[],
  rules: {
    name: [
      {required: true, message: '请输入名字', trigger: 'blur'}
    ],
    typeId: [
      {required: true, message: '请输入分类', trigger: 'change'},
    ],
    price: [
      {required: true, message: '请输入价格', trigger: 'blur'},
    ],

  },
  shopList:[],
  typeList:[],
  content: null,
  viewVisible: false,
  typeName:'',


})

// 获取宠物店列表
request.get('/petShop/selectAll').then(res => {
  data.shopList = res.data
})

// 获取宠物类型列表
request.get('/goodsType/selectAll').then(res => {
  // 将请求响应数据赋值给data中的typeList
  data.typeList = res.data;

})

//wangeditor5 初始化开始
const baseUrl = 'https://localhost:8080'
const editorRef = shallowRef()
const mode = 'default'
const editorConfig={MENU_CONF:{}}
//图片上传配置
editorConfig.MENU_CONF['uploadImage']={
  server:baseUrl+'files/wang/upload',  //服务端图片上传接口
  fiedldName:'file'  //服务端图片上传接口参数名
}
//组件销毁时，清除编辑器实例
onBeforeUnmount(() => {
  const editor = editorRef.value
  if(editor == null) return
  editor.destroy()
})
//记录editor事件 重要
const handleCreated = (editor) =>{
  editorRef.value = editor
}
//wangeditor5 初始化结束


const view = (content) => {
  data.content = content
  data.viewVisible = true
}

const handleAvatarSuccess = (res, file) => {
  data.form.img = res.data
}

// 分页加载数据
const load = () => {
  request.get('/goods/selectPage', {
    params: {
      pageNum: data.pageNum,
      pageSize: data.pageSize,
      name: data.name,
      typeName:'',
      shopId: data.user.role === 'PETSHOP' ? data.user.id : null // 新增：如果角色是 PETSHOP，则传递 shopId
    }
  }).then(res => {
    // 更新表格数据，通过映射远程获取的列表信息，并 enriched 数据
    data.tableData = res.data.list
    data.total = res.data.total;
  });
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
  data.formVisible = true  // 确保 formVisible 设置为 true
  data.form = {  status: '上架',shopId : data.user.id}
}
// 保存
const save = () => {   //两个操作，新增和修改，都使用save方法
  if(!data.form.img){
    ElMessage.error('请上传图片')
    return
  }
  formRef.value.validate((valid)=>{    //表单验证
    if (valid) {
      data.form.id ? update() : add()
    }
  })
}

// 新增
const add= () => {
  request.post('/goods/add', data.form).then(res => {
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
  request.put('/goods/update', data.form).then(res => {
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
  ElMessageBox.confirm('确认删除该商品信息吗？','删除确认', {type: 'warning'}).then(() => {
    request.delete('/goods/deleteById/' + id).then(res => {
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
  ElMessageBox.confirm('确认删除该商品信息吗？', '删除确认', {type: 'warning'}).then(() => {
    request.delete('/goods/deleteBatch', {data: data.ids}).then(res => {
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

.myTooltip {
  max-width: 40% !important;
}
</style>