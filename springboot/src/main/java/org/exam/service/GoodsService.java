package org.exam.service;

import cn.hutool.core.util.StrUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import jakarta.annotation.Resource;
import org.exam.common.RoleEnum;
import org.exam.entity.Account;
import org.exam.entity.Goods;
import org.exam.exception.CustomException;
import org.exam.mapper.GoodsMapper;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class GoodsService {

    @Resource
    private GoodsMapper goodsMapper;

    public List<Goods> selectAll(Goods goods) {
        return goodsMapper.selectAll(goods);
    }

    public Goods selectById(Integer id) {
        return goodsMapper.selectById(id);

    }

    public PageInfo<Goods> selectPage(Goods goods, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum,pageSize);
        List<Goods> list=goodsMapper.selectAll(goods);
        return PageInfo.of(list);
    }

    public void add(Goods goods) {
        goodsMapper.insert(goods);
    }

    public void update(Goods goods) {
        goodsMapper.updateById(goods);
    }

    public void deleteById(Integer id) {
        goodsMapper.deleteById(id);
    }

    public void deleteBatch(List<Integer> ids) {
        for(Integer id : ids){
            goodsMapper.deleteById(id);
        }
    }

}