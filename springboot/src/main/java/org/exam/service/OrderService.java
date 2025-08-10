package org.exam.service;

import cn.hutool.core.util.StrUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import jakarta.annotation.Resource;
import org.exam.common.RoleEnum;
import org.exam.entity.Account;
import org.exam.entity.Order;
import org.exam.exception.CustomException;
import org.exam.mapper.OrderMapper;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class OrderService {

    @Resource
    private OrderMapper orderMapper;

    public List<Order> selectAll(Order order) {
        return orderMapper.selectAll(order);
    }

    public Order selectById(Integer id) {
        return orderMapper.selectById(id);

    }

    public PageInfo<Order> selectPage(Order order, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum,pageSize);
        List<Order> list=orderMapper.selectAll(order);
        return PageInfo.of(list);
    }

    public void add(Order order) {
        orderMapper.insert(order);
    }

    public void update(Order order) {
        orderMapper.updateById(order);
    }

    public void deleteById(Integer id) {
        orderMapper.deleteById(id);
    }

    public void deleteBatch(List<Integer> ids) {
        for(Integer id : ids){
            orderMapper.deleteById(id);
        }
    }

}