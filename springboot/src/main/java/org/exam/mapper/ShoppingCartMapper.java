package org.exam.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.exam.entity.ShoppingCart;

import java.util.List;

@Mapper
public interface ShoppingCartMapper {
    List<ShoppingCart> selectAll(ShoppingCart shopping_cart);

    void insert(ShoppingCart shopping_cart);

    void updateById(ShoppingCart shopping_cart);

    @Select("delete from shopping_cart where id=#{id}")
    void deleteById(Integer id);

    @Select("select *from shopping_cart where id=#{id}")
    ShoppingCart selectById(Integer id);


}
