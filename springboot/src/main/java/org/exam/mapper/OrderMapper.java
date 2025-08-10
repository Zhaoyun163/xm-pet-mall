package org.exam.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.exam.entity.Order;

import java.util.List;

@Mapper
public interface OrderMapper {
    List<Order> selectAll(Order order);

    void insert(Order order);

    void updateById(Order order);

    @Select("delete from `order` where id=#{id}")
    void deleteById(Integer id);

    @Select("select *from `order` where id=#{id}")
    Order selectById(Integer id);


}
