package org.exam.service;

import cn.hutool.core.util.StrUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import jakarta.annotation.Resource;
import org.exam.common.RoleEnum;
import org.exam.entity.Account;
import org.exam.entity.Pet;
import org.exam.exception.CustomException;
import org.exam.mapper.PetMapper;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PetService {

    @Resource
    private PetMapper petMapper;

    public List<Pet> selectAll(Pet pet) {
        return petMapper.selectAll(pet);
    }

    public Pet selectById(Integer id) {
        return petMapper.selectById(id);

    }

    public PageInfo<Pet> selectPage(Pet pet, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum,pageSize);
        List<Pet> list=petMapper.selectAll(pet);
        return PageInfo.of(list);
    }

    public void add(Pet pet) {
        petMapper.insert(pet);
    }

    public void update(Pet pet) {
        petMapper.updateById(pet);
    }

    public void deleteById(Integer id) {
        petMapper.deleteById(id);
    }

    public void deleteBatch(List<Integer> ids) {
        for(Integer id : ids){
            petMapper.deleteById(id);
        }
    }

}