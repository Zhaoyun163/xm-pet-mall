package org.exam.service;

import cn.hutool.core.util.StrUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import jakarta.annotation.Resource;
import org.exam.entity.Account;
import org.exam.entity.GoodsType;
import org.exam.exception.CustomException;
import org.exam.mapper.GoodsTypeMapper;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class GoodsTypeService {

    @Resource
    private GoodsTypeMapper goodsTypeMapper;

    public List<GoodsType> selectAll(GoodsType goodsType) {
        return goodsTypeMapper.selectAll(goodsType);
    }

    public GoodsType selectById(Integer id) {
        return goodsTypeMapper.selectById(id);

    }

    public PageInfo<GoodsType> selectPage(GoodsType goodsType, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum,pageSize);
        List<GoodsType> list=goodsTypeMapper.selectAll(goodsType);
        return PageInfo.of(list);
    }

    public void add(GoodsType goodsType) {
        goodsTypeMapper.insert(goodsType);
    }

    public void update(GoodsType goodsType) {
        goodsTypeMapper.updateById(goodsType);
    }

    public void deleteById(Integer id) {
        goodsTypeMapper.deleteById(id);
    }

    public void deleteBatch(List<Integer> ids) {
        for(Integer id : ids){
            goodsTypeMapper.deleteById(id);
        }
    }




}