package org.exam.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.exam.entity.Pet;

import java.util.List;

@Mapper
public interface PetMapper {
    List<Pet> selectAll(Pet pet);

    void insert(Pet pet);

    void updateById(Pet pet);

    @Select("delete from pet where id=#{id}")
    void deleteById(Integer id);

    @Select("select *from pet where id=#{id}")
    Pet selectById(Integer id);


}
