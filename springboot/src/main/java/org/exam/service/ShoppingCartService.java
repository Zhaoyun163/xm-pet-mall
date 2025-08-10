package org.exam.service;

import cn.hutool.core.util.StrUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import jakarta.annotation.Resource;
import org.exam.common.RoleEnum;
import org.exam.entity.Account;
import org.exam.entity.ShoppingCart;
import org.exam.exception.CustomException;
import org.exam.mapper.ShoppingCartMapper;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ShoppingCartService {

    @Resource
    private ShoppingCartMapper shoppingCartMapper;

    public List<ShoppingCart> selectAll(ShoppingCart shoppingCart) {
        return shoppingCartMapper.selectAll(shoppingCart);
    }

    public ShoppingCart selectById(Integer id) {
        return shoppingCartMapper.selectById(id);

    }

    public PageInfo<ShoppingCart> selectPage(ShoppingCart shoppingCart, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum,pageSize);
        List<ShoppingCart> list=shoppingCartMapper.selectAll(shoppingCart);
        return PageInfo.of(list);
    }

    public void add(ShoppingCart shoppingCart) {
        shoppingCartMapper.insert(shoppingCart);
    }

    public void update(ShoppingCart shoppingCart) {
        shoppingCartMapper.updateById(shoppingCart);
    }

    public void deleteById(Integer id) {
        shoppingCartMapper.deleteById(id);
    }

    public void deleteBatch(List<Integer> ids) {
        for(Integer id : ids){
            shoppingCartMapper.deleteById(id);
        }
    }

}