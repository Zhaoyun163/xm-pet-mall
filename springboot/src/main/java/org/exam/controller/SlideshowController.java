package org.exam.controller;


import com.github.pagehelper.PageInfo;
import jakarta.annotation.Resource;
import org.exam.common.Result;
import org.exam.entity.Slideshow;
import org.exam.service.SlideshowService;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/slideshow")
public class SlideshowController {
    
    @Resource
    private SlideshowService slideshowService;
    
    
    //查询所有数据
    @GetMapping("/selectAll")
    public Result selectAll(Slideshow slideshow){
        List<Slideshow> list=slideshowService.selectAll(slideshow);
        return Result.success(list);
    }

    //查询单个数据
    @GetMapping("selectById/{id}")
    public Result selectById(@PathVariable("id") Integer id){
        Slideshow slideshow=slideshowService.selectById(id);
        return Result.success(slideshow);
    }

    //分页查询
    @GetMapping("/selectPage")
    public Result selectPage(Slideshow slideshow,
             @RequestParam(defaultValue = "1") Integer pageNum,
             @RequestParam(defaultValue = "5") Integer pageSize) {

        PageInfo<Slideshow> pageInfo=slideshowService.selectPage(slideshow,pageNum,pageSize);
        return Result.success(pageInfo);

    }

    //增加数据
    @PostMapping("/add")
    public Result add(@RequestBody Slideshow slideshow){
        slideshowService.add(slideshow);
        return Result.success();
    }

    //修改数据
    @PutMapping("/update")
    public Result update(@RequestBody Slideshow slideshow){
        slideshowService.update(slideshow);
        return Result.success();
    }

    //删除数据
    @DeleteMapping("/deleteById/{id}")
    public Result deleteById(@PathVariable Integer id){
        slideshowService.deleteById(id);
        return Result.success();
    }

    //批量删除
    @DeleteMapping("/deleteBatch")
    public Result deleteBatch(@RequestBody List<Integer> ids){
        slideshowService.deleteBatch(ids);
        return Result.success();
    }



    
    
}
