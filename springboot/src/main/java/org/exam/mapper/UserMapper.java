package org.exam.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.exam.entity.User;

import java.util.List;

@Mapper
public interface UserMapper {
    List<User> selectAll(User user);

    void insert(User user);

    void updateById(User user);

    @Select("delete from user where id=#{id}")
    void deleteById(Integer id);

    @Select("select *from user where id=#{id}")
    User selectById(Integer id);

    @Select("select * from user where username=#{username}")
    User selectByUsername(String username);
}
