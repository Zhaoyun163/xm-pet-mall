package org.exam.controller;


import com.github.pagehelper.PageInfo;
import jakarta.annotation.Resource;
import org.exam.common.Result;
import org.exam.entity.PetShop;
import org.exam.service.PetShopService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/petShop")
public class PetShopController {
    
    @Resource
    private PetShopService petShopService;
    
    
    //查询所有数据
    @GetMapping("/selectAll")
    public Result selectAll(PetShop petShop){
        List<PetShop> list=petShopService.selectAll(petShop);
        return Result.success(list);
    }

    //查询单个数据
    @GetMapping("selectById/{id}")
    public Result selectById(@PathVariable("id") Integer id){
        PetShop petShop=petShopService.selectById(id);
        return Result.success(petShop);
    }

    //分页查询
    @GetMapping("/selectPage")
    public Result selectPage(PetShop petShop,
             @RequestParam(defaultValue = "1") Integer pageNum,
             @RequestParam(defaultValue = "5") Integer pageSize) {

        PageInfo<PetShop> pageInfo=petShopService.selectPage(petShop,pageNum,pageSize);
        return Result.success(pageInfo);

    }

    //增加数据
    @PostMapping("/add")
    public Result add(@RequestBody PetShop petShop){
        petShopService.add(petShop);
        return Result.success();
    }

    //修改数据
    @PutMapping("/update")
    public Result update(@RequestBody PetShop petShop){
        petShopService.update(petShop);
        return Result.success();
    }

    //修改认证
    @PutMapping("/identify")
    public Result identify(@RequestBody PetShop petShop){
        petShopService.identify(petShop);
        return Result.success();
    }

    //删除数据
    @DeleteMapping("/deleteById/{id}")
    public Result deleteById(@PathVariable Integer id){
        petShopService.deleteById(id);
        return Result.success();
    }

    //批量删除
    @DeleteMapping("/deleteBatch")
    public Result deleteBatch(@RequestBody List<Integer> ids){
        petShopService.deleteBatch(ids);
        return Result.success();
    }



    
    
}
