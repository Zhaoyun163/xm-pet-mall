package org.exam.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.exam.entity.Slideshow;
import java.util.List;

@Mapper
public interface SlideshowMapper {
    List<Slideshow> selectAll(Slideshow slideshow);

    void insert(Slideshow slideshow);

    void updateById(Slideshow slideshow);

    @Select("delete from slideshow where id=#{id}")
    void deleteById(Integer id);

    @Select("select *from slideshow where id=#{id}")
    Slideshow selectById(Integer id);

    @Select("select * from slideshow where username=#{username}")
    Slideshow selectByUsername(String username);
}
