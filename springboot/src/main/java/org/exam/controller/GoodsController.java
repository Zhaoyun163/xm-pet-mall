package org.exam.controller;


import com.github.pagehelper.PageInfo;
import jakarta.annotation.Resource;
import org.exam.common.Result;
import org.exam.entity.Goods;
import org.exam.service.GoodsService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/goods")
public class GoodsController {
    
    @Resource
    private GoodsService goodsService;
    
    
    //查询所有数据
    @GetMapping("/selectAll")
    public Result selectAll(Goods goods){
        List<Goods> list=goodsService.selectAll(goods);
        return Result.success(list);
    }

    //查询单个数据
    @GetMapping("selectById/{id}")
    public Result selectById(@PathVariable("id") Integer id){
        Goods goods=goodsService.selectById(id);
        return Result.success(goods);
    }

    //分页查询
    @GetMapping("/selectPage")
    public Result selectPage(Goods goods,
             @RequestParam(defaultValue = "1") Integer pageNum,
             @RequestParam(defaultValue = "8") Integer pageSize)
    {
        PageInfo<Goods> pageInfo=goodsService.selectPage(goods,pageNum,pageSize);
        return Result.success(pageInfo);

    }

    //增加数据
    @PostMapping("/add")
    public Result add(@RequestBody Goods goods){
        goodsService.add(goods);
        return Result.success();
    }

    //修改数据
    @PutMapping("/update")
    public Result update(@RequestBody Goods goods){
        goodsService.update(goods);
        return Result.success();
    }

    //删除数据
    @DeleteMapping("/deleteById/{id}")
    public Result deleteById(@PathVariable Integer id){
        goodsService.deleteById(id);
        return Result.success();
    }

    //批量删除
    @DeleteMapping("/deleteBatch")
    public Result deleteBatch(@RequestBody List<Integer> ids){
        goodsService.deleteBatch(ids);
        return Result.success();
    }



    
    
}
