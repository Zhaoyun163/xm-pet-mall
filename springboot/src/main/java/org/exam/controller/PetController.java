package org.exam.controller;


import com.github.pagehelper.PageInfo;
import jakarta.annotation.Resource;
import org.exam.common.Result;
import org.exam.entity.Pet;
import org.exam.service.PetService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/pet")
public class PetController {
    
    @Resource
    private PetService petService;
    
    
    //查询所有数据
    @GetMapping("/selectAll")
    public Result selectAll(Pet pet){
        List<Pet> list=petService.selectAll(pet);
        return Result.success(list);
    }

    //查询单个数据
    @GetMapping("selectById/{id}")
    public Result selectById(@PathVariable("id") Integer id){
        Pet pet=petService.selectById(id);
        return Result.success(pet);
    }

    //分页查询
    @GetMapping("/selectPage")
    public Result selectPage(Pet pet,
             @RequestParam(defaultValue = "1") Integer pageNum,
             @RequestParam(defaultValue = "8") Integer pageSize)
    {
        PageInfo<Pet> pageInfo=petService.selectPage(pet,pageNum,pageSize);
        return Result.success(pageInfo);

    }

    //增加数据
    @PostMapping("/add")
    public Result add(@RequestBody Pet pet){
        petService.add(pet);
        return Result.success();
    }

    //修改数据
    @PutMapping("/update")
    public Result update(@RequestBody Pet pet){
        petService.update(pet);
        return Result.success();
    }

    //删除数据
    @DeleteMapping("/deleteById/{id}")
    public Result deleteById(@PathVariable Integer id){
        petService.deleteById(id);
        return Result.success();
    }

    //批量删除
    @DeleteMapping("/deleteBatch")
    public Result deleteBatch(@RequestBody List<Integer> ids){
        petService.deleteBatch(ids);
        return Result.success();
    }



    
    
}
