package org.exam.controller;


import com.github.pagehelper.PageInfo;
import jakarta.annotation.Resource;
import org.exam.common.Result;
import org.exam.entity.Order;
import org.exam.service.OrderService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/order")
public class OrderController {
    
    @Resource
    private OrderService orderService;
    
    
    //查询所有数据
    @GetMapping("/selectAll")
    public Result selectAll(Order order){
        List<Order> list=orderService.selectAll(order);
        return Result.success(list);
    }

    //查询单个数据
    @GetMapping("selectById/{id}")
    public Result selectById(@PathVariable("id") Integer id){
        Order order=orderService.selectById(id);
        return Result.success(order);
    }

    //分页查询
    @GetMapping("/selectPage")
    public Result selectPage(Order order,
             @RequestParam(defaultValue = "1") Integer pageNum,
             @RequestParam(defaultValue = "8") Integer pageSize)
    {
        PageInfo<Order> pageInfo=orderService.selectPage(order,pageNum,pageSize);
        return Result.success(pageInfo);

    }

    //增加数据
    @PostMapping("/add")
    public Result add(@RequestBody Order order){
        orderService.add(order);
        return Result.success();
    }

    //修改数据
    @PutMapping("/update")
    public Result update(@RequestBody Order order){
        orderService.update(order);
        return Result.success();
    }

    //删除数据
    @DeleteMapping("/deleteById/{id}")
    public Result deleteById(@PathVariable Integer id){
        orderService.deleteById(id);
        return Result.success();
    }

    //批量删除
    @DeleteMapping("/deleteBatch")
    public Result deleteBatch(@RequestBody List<Integer> ids){
        orderService.deleteBatch(ids);
        return Result.success();
    }



    
    
}
