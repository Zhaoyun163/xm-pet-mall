package org.exam.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.exam.entity.GoodsType;
import java.util.List;

@Mapper
public interface GoodsTypeMapper {
    List<GoodsType> selectAll(GoodsType goodsType);

    void insert(GoodsType goodsType);

    void updateById(GoodsType goodsType);

    @Select("delete from goods_type where id=#{id}")
    void deleteById(Integer id);

    @Select("select *from goods_type where id=#{id}")
    GoodsType selectById(Integer id);

    @Select("select * from goods_type where username=#{username}")
    GoodsType selectByUsername(String username);
}
