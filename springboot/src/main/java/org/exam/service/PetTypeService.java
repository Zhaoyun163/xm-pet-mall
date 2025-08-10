package org.exam.service;

import cn.hutool.core.util.StrUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import jakarta.annotation.Resource;
import org.exam.entity.Account;
import org.exam.entity.PetType;
import org.exam.exception.CustomException;
import org.exam.mapper.PetTypeMapper;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PetTypeService {

    @Resource
    private PetTypeMapper petTypeMapper;

    public List<PetType> selectAll(PetType petType) {
        return petTypeMapper.selectAll(petType);
    }

    public PetType selectById(Integer id) {
        return petTypeMapper.selectById(id);

    }

    public PageInfo<PetType> selectPage(PetType petType, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum,pageSize);
        List<PetType> list=petTypeMapper.selectAll(petType);
        return PageInfo.of(list);
    }

    public void add(PetType petType) {
        petTypeMapper.insert(petType);
    }

    public void update(PetType petType) {
        petTypeMapper.updateById(petType);
    }

    public void deleteById(Integer id) {
        petTypeMapper.deleteById(id);
    }

    public void deleteBatch(List<Integer> ids) {
        for(Integer id : ids){
            petTypeMapper.deleteById(id);
        }
    }




}