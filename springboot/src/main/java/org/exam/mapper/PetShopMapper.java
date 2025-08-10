package org.exam.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.exam.entity.PetShop;
import java.util.List;

@Mapper
public interface PetShopMapper {
    List<PetShop> selectAll(PetShop petShop);

    void insert(PetShop petShop);

    void updateById(PetShop petShop);

    @Select("delete from pet_shop where id=#{id}")
    void deleteById(Integer id);

    @Select("select *from pet_shop where id=#{id}")
    PetShop selectById(Integer id);

    @Select("select * from pet_shop where username=#{username}")
    PetShop selectByUsername(String username);
}
