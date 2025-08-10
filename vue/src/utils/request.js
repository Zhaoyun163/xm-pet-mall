import axios from 'axios'
import {ElMessage} from "element-plus";

const request = axios.create({
  baseURL: 'http://localhost:8080/',
  timeout: 30000  //后台30秒超时
})

// 前后端请求工具类

// request拦截器
// 可以在请求发出之前做一些处理
request.interceptors.request.use(config => {
    config.headers['Content-Type'] = 'application/json;charset=UTF-8';
    return config
}, error => {
    return Promise.reject(error)
});


// response拦截器
// 可以在请求成功之后做一些处理
request.interceptors.response.use(
    response => {
        let res = response.data;
        if(typeof res === 'string') {
            res = res ?JSON.parse(res) : res
        }
        return res;
    },
    error => {
        if (error.response.status === 404) {
            ElMessage.error('404错误，找不到请求接口');
        }else if (error.response.status === 500) {
            ElMessage.error('500错误，服务器错误，请在后端控制台查看');
        }else {
            console.error(error.message)
        }
        return Promise.reject(error)
    }
)

export default request;


