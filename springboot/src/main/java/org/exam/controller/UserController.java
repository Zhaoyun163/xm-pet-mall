package org.exam.controller;


import com.github.pagehelper.PageInfo;
import jakarta.annotation.Resource;
import org.exam.common.Result;
import org.exam.entity.User;
import org.exam.service.UserService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/user")
public class UserController {
    
    @Resource
    private UserService userService;
    
    
    //查询所有数据
    @GetMapping("/selectAll")
    public Result selectAll(User user){
        List<User> list=userService.selectAll(user);
        return Result.success(list);
    }

    //查询单个数据
    @GetMapping("selectById/{id}")
    public Result selectById(@PathVariable("id") Integer id){
        User user=userService.selectById(id);
        return Result.success(user);
    }

    //分页查询
    @GetMapping("/selectPage")
    public Result selectPage(User user,
             @RequestParam(defaultValue = "1") Integer pageNum,
             @RequestParam(defaultValue = "5") Integer pageSize) {

        PageInfo<User> pageInfo=userService.selectPage(user,pageNum,pageSize);
        return Result.success(pageInfo);

    }

    //增加数据
    @PostMapping("/add")
    public Result add(@RequestBody User user){
        userService.add(user);
        return Result.success();
    }

    //修改数据
    @PutMapping("/update")
    public Result update(@RequestBody User user){
        userService.update(user);
        return Result.success();
    }

    //删除数据
    @DeleteMapping("/deleteById/{id}")
    public Result deleteById(@PathVariable Integer id){
        userService.deleteById(id);
        return Result.success();
    }

    //批量删除
    @DeleteMapping("/deleteBatch")
    public Result deleteBatch(@RequestBody List<Integer> ids){
        userService.deleteBatch(ids);
        return Result.success();
    }



    
    
}
