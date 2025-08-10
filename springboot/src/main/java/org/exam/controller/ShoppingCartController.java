package org.exam.controller;


import com.github.pagehelper.PageInfo;
import jakarta.annotation.Resource;
import org.exam.common.Result;
import org.exam.entity.ShoppingCart;
import org.exam.service.ShoppingCartService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/shoppingCart")
public class ShoppingCartController {
    
    @Resource
    private ShoppingCartService shoppingCartService;
    
    
    //查询所有数据
    @GetMapping("/selectAll")
    public Result selectAll(ShoppingCart shoppingCart){
        List<ShoppingCart> list=shoppingCartService.selectAll(shoppingCart);
        return Result.success(list);
    }

    //查询单个数据
    @GetMapping("selectById/{id}")
    public Result selectById(@PathVariable("id") Integer id){
        ShoppingCart shoppingCart=shoppingCartService.selectById(id);
        return Result.success(shoppingCart);
    }

    //分页查询
    @GetMapping("/selectPage")
    public Result selectPage(ShoppingCart shoppingCart,
             @RequestParam(defaultValue = "1") Integer pageNum,
             @RequestParam(defaultValue = "8") Integer pageSize)
    {
        PageInfo<ShoppingCart> pageInfo=shoppingCartService.selectPage(shoppingCart,pageNum,pageSize);
        return Result.success(pageInfo);

    }

    //增加数据
    @PostMapping("/add")
    public Result add(@RequestBody ShoppingCart shoppingCart){
        shoppingCartService.add(shoppingCart);
        return Result.success();
    }

    //修改数据
    @PutMapping("/update")
    public Result update(@RequestBody ShoppingCart shoppingCart){
        shoppingCartService.update(shoppingCart);
        return Result.success();
    }

    //删除数据
    @DeleteMapping("/deleteById/{id}")
    public Result deleteById(@PathVariable Integer id){
        shoppingCartService.deleteById(id);
        return Result.success();
    }

    //批量删除
    @DeleteMapping("/deleteBatch")
    public Result deleteBatch(@RequestBody List<Integer> ids){
        shoppingCartService.deleteBatch(ids);
        return Result.success();
    }



    
    
}
