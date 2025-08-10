package org.exam.service;

import cn.hutool.core.util.StrUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import jakarta.annotation.Resource;
import org.exam.entity.Account;
import org.exam.entity.Slideshow;
import org.exam.exception.CustomException;
import org.exam.mapper.SlideshowMapper;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SlideshowService {

    @Resource
    private SlideshowMapper slideshowMapper;

    public List<Slideshow> selectAll(Slideshow slideshow) {
        return slideshowMapper.selectAll(slideshow);
    }

    public Slideshow selectById(Integer id) {
        return slideshowMapper.selectById(id);

    }

    public PageInfo<Slideshow> selectPage(Slideshow slideshow, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum,pageSize);
        List<Slideshow> list=slideshowMapper.selectAll(slideshow);
        return PageInfo.of(list);
    }

    public void add(Slideshow slideshow) {
        slideshowMapper.insert(slideshow);
    }

    public void update(Slideshow slideshow) {
        slideshowMapper.updateById(slideshow);
    }

    public void deleteById(Integer id) {
        slideshowMapper.deleteById(id);
    }

    public void deleteBatch(List<Integer> ids) {
        for(Integer id : ids){
            slideshowMapper.deleteById(id);
        }
    }




}