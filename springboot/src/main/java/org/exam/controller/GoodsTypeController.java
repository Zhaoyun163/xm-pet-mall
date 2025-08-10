package org.exam.controller;


import com.github.pagehelper.PageInfo;
import jakarta.annotation.Resource;
import org.exam.common.Result;
import org.exam.entity.GoodsType;
import org.exam.service.GoodsTypeService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/goodsType")
public class GoodsTypeController {
    
    @Resource
    private GoodsTypeService goodsTypeService;
    
    
    //查询所有数据
    @GetMapping("/selectAll")
    public Result selectAll(GoodsType goodsType){
        List<GoodsType> list=goodsTypeService.selectAll(goodsType);
        return Result.success(list);
    }

    //查询单个数据
    @GetMapping("selectById/{id}")
    public Result selectById(@PathVariable("id") Integer id){
        GoodsType goodsType=goodsTypeService.selectById(id);
        return Result.success(goodsType);
    }

    //分页查询
    @GetMapping("/selectPage")
    public Result selectPage(GoodsType goodsType,
             @RequestParam(defaultValue = "1") Integer pageNum,
             @RequestParam(defaultValue = "5") Integer pageSize) {

        PageInfo<GoodsType> pageInfo=goodsTypeService.selectPage(goodsType,pageNum,pageSize);
        return Result.success(pageInfo);

    }

    //增加数据
    @PostMapping("/add")
    public Result add(@RequestBody GoodsType goodsType){
        goodsTypeService.add(goodsType);
        return Result.success();
    }

    //修改数据
    @PutMapping("/update")
    public Result update(@RequestBody GoodsType goodsType){
        goodsTypeService.update(goodsType);
        return Result.success();
    }

    //删除数据
    @DeleteMapping("/deleteById/{id}")
    public Result deleteById(@PathVariable Integer id){
        goodsTypeService.deleteById(id);
        return Result.success();
    }

    //批量删除
    @DeleteMapping("/deleteBatch")
    public Result deleteBatch(@RequestBody List<Integer> ids){
        goodsTypeService.deleteBatch(ids);
        return Result.success();
    }



    
    
}
