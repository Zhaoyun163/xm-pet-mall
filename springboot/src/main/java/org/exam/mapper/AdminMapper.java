package org.exam.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.exam.entity.Admin;

import java.util.List;

@Mapper
public interface AdminMapper {
    List<Admin> selectAll(Admin admin);

    void insert(Admin admin);

    void updateById(Admin admin);

    @Select("delete from admin where id=#{id}")
    void deleteById(Integer id);

    @Select("select *from admin where id=#{id}")
    Admin selectById(Integer id);

    @Select("select * from admin where username=#{username}")
    Admin selectByUsername(String username);
}
