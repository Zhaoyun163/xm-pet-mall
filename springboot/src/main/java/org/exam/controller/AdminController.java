package org.exam.controller;


import com.github.pagehelper.PageInfo;
import jakarta.annotation.Resource;
import org.exam.common.Result;
import org.exam.entity.Admin;
import org.exam.service.AdminService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/admin")
public class AdminController {
    
    @Resource
    private AdminService adminService;
    
    
    //查询所有数据
    @GetMapping("/selectAll")
    public Result selectAll(Admin admin){
        List<Admin> list=adminService.selectAll(admin);
        return Result.success(list);
    }

    //查询单个数据
    @GetMapping("selectById/{id}")
    public Result selectById(@PathVariable("id") Integer id){
        Admin admin=adminService.selectById(id);
        return Result.success(admin);
    }

    //分页查询
    @GetMapping("/selectPage")
    public Result selectPage(Admin admin,
             @RequestParam(defaultValue = "1") Integer pageNum,
             @RequestParam(defaultValue = "5") Integer pageSize) {

        PageInfo<Admin> pageInfo=adminService.selectPage(admin,pageNum,pageSize);
        return Result.success(pageInfo);

    }

    //增加数据
    @PostMapping("/add")
    public Result add(@RequestBody Admin admin){
        adminService.add(admin);
        return Result.success();
    }

    //修改数据
    @PutMapping("/update")
    public Result update(@RequestBody Admin admin){
        adminService.update(admin);
        return Result.success();
    }

    //删除数据
    @DeleteMapping("/deleteById/{id}")
    public Result deleteById(@PathVariable Integer id){
        adminService.deleteById(id);
        return Result.success();
    }

    //批量删除
    @DeleteMapping("/deleteBatch")
    public Result deleteBatch(@RequestBody List<Integer> ids){
        adminService.deleteBatch(ids);
        return Result.success();
    }



    
    
}
