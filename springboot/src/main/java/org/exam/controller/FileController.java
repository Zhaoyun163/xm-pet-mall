package org.exam.controller;

import cn.hutool.core.io.FileUtil;
import jakarta.servlet.http.HttpServletResponse;
import org.exam.common.Result;
import org.exam.exception.CustomException;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


//文件上传下载的类
@RestController
@RequestMapping("/files")
public class FileController {

    private static final String filePath=System.getProperty("user.dir")+"/files/";//获取项目路径

    //文件上传
    @PostMapping("/upload")
    public Result upload(MultipartFile file) {
        String originalFilename = file.getOriginalFilename();//获取文件名
        if(!FileUtil.isDirectory(filePath)){  //判断文件夹是否存在，不存在则创建
            FileUtil.mkdir(filePath);  //创建文件路径
        }
        String fileName=System.currentTimeMillis()+"_"+originalFilename;  //重命名加上时间戳+文件名
        String realPath = filePath + fileName;  //拼接文件完整路径
        try {
            FileUtil.writeBytes(file.getBytes(),realPath); //写入文件
        } catch (IOException e) {
            throw new CustomException("500","文件上传失败");
        }
        //返回一个网络连接

        String url="http://localhost:8080/files/download/" + fileName;  //拼接文件下载路径
        return Result.success(url);
    }

    //文件下载
    @GetMapping("/download/{fileName}")
    public void download(@PathVariable String fileName, HttpServletResponse response) {
        try {
            response.addHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(fileName, StandardCharsets.UTF_8));  //设置响应头
            response.setContentType("application/octet-stream");  //设置响应类型
            OutputStream os = response.getOutputStream(); //获取输出流
            String realPath = filePath + fileName;  //拼接文件完整路径
            byte[] bytes = FileUtil.readBytes(realPath);  //读取文件
            os.write(bytes);  //写入输出流
            os.flush();  //刷新输出流
            os.close();  //关闭输出流
        } catch (IOException e) {
            throw new CustomException("500","文件下载失败");
        }
    }

    //wang editor上传接口  富文本
    @PostMapping("/wang/upload")
    public Map<String, Object> wangEditorUpload(MultipartFile file){
        String originalFilename = file.getOriginalFilename();//获取文件名
        System.out.println("原始文件名: " + originalFilename);
        if(!FileUtil.isDirectory(filePath)){  //判断文件夹是否存在，不存在则创建
            FileUtil.mkdir(filePath);  //创建文件路径
        }
        String fileName=System.currentTimeMillis()+"_"+originalFilename;  //重命名加上时间戳+文件名
        String realPath=filePath+fileName;  //拼接文件完整路径
        try {
            FileUtil.writeBytes(file.getBytes(),realPath); //写入文件
        } catch (IOException e) {
            throw new CustomException("500","文件上传失败");
        }
        String url="http://localhost:8080/files/download/"+fileName;  //拼接文件下载路径
        //wangeditor上传成功 需要返回数据

        Map<String, Object> resMap = new HashMap<>();
        List<Map<String, Object>> list = new ArrayList<>();
        Map<String, Object> urMap = new HashMap<>();
        urMap.put("url", url);
        list.add(urMap);
        resMap.put("errno", 0);
        resMap.put("data", list);
        return resMap;
    }

}
