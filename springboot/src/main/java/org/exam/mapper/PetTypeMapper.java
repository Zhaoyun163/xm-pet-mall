package org.exam.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.exam.entity.PetType;
import java.util.List;

@Mapper
public interface PetTypeMapper {
    List<PetType> selectAll(PetType petType);

    void insert(PetType petType);

    void updateById(PetType petType);

    @Select("delete from pet_type where id=#{id}")
    void deleteById(Integer id);

    @Select("select *from pet_type where id=#{id}")
    PetType selectById(Integer id);

    @Select("select * from pet_type where username=#{username}")
    PetType selectByUsername(String username);
}
