package org.exam.controller;


import com.github.pagehelper.PageInfo;
import jakarta.annotation.Resource;
import org.exam.common.Result;
import org.exam.entity.PetType;
import org.exam.service.PetTypeService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/petType")
public class PetTypeController {
    
    @Resource
    private PetTypeService petTypeService;
    
    
    //查询所有数据
    @GetMapping("/selectAll")
    public Result selectAll(PetType petType){
        List<PetType> list=petTypeService.selectAll(petType);
        return Result.success(list);
    }

    //查询单个数据
    @GetMapping("selectById/{id}")
    public Result selectById(@PathVariable("id") Integer id){
        PetType petType=petTypeService.selectById(id);
        return Result.success(petType);
    }

    //分页查询
    @GetMapping("/selectPage")
    public Result selectPage(PetType petType,
             @RequestParam(defaultValue = "1") Integer pageNum,
             @RequestParam(defaultValue = "5") Integer pageSize) {

        PageInfo<PetType> pageInfo=petTypeService.selectPage(petType,pageNum,pageSize);
        return Result.success(pageInfo);

    }

    //增加数据
    @PostMapping("/add")
    public Result add(@RequestBody PetType petType){
        petTypeService.add(petType);
        return Result.success();
    }

    //修改数据
    @PutMapping("/update")
    public Result update(@RequestBody PetType petType){
        petTypeService.update(petType);
        return Result.success();
    }

    //删除数据
    @DeleteMapping("/deleteById/{id}")
    public Result deleteById(@PathVariable Integer id){
        petTypeService.deleteById(id);
        return Result.success();
    }

    //批量删除
    @DeleteMapping("/deleteBatch")
    public Result deleteBatch(@RequestBody List<Integer> ids){
        petTypeService.deleteBatch(ids);
        return Result.success();
    }



    
    
}
