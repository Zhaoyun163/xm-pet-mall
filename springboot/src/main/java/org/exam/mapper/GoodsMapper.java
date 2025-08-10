package org.exam.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.exam.entity.Goods;

import java.util.List;

@Mapper
public interface GoodsMapper {
    List<Goods> selectAll(Goods goods);

    void insert(Goods goods);

    void updateById(Goods goods);

    @Select("delete from goods where id=#{id}")
    void deleteById(Integer id);

    @Select("select *from goods where id=#{id}")
    Goods selectById(Integer id);


}
