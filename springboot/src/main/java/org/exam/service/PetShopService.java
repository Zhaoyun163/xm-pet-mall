package org.exam.service;

import cn.hutool.core.util.ObjectUtil;
import cn.hutool.core.util.StrUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import jakarta.annotation.Resource;
import org.exam.common.Constants;
import org.exam.common.RoleEnum;
import org.exam.entity.Account;
import org.exam.entity.Admin;
import org.exam.entity.PetShop;
import org.exam.exception.CustomException;
import org.exam.mapper.PetShopMapper;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class PetShopService {

    @Resource
    private PetShopMapper petShopMapper;

    public List<PetShop> selectAll(PetShop petShop) {
        return petShopMapper.selectAll(petShop);
    }

    public PetShop selectById(Integer id) {
        return petShopMapper.selectById(id);

    }

    public PageInfo<PetShop> selectPage(PetShop petShop, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum,pageSize);
        List<PetShop> list=petShopMapper.selectAll(petShop);
        return PageInfo.of(list);
    }

    public void add(PetShop petShop) {
        PetShop dbPetShop = petShopMapper.selectByUsername(petShop.getUsername());
        if(dbPetShop != null){
            throw new CustomException("500","用户名已存在");
        }
        if(ObjectUtil.isEmpty(petShop.getPassword())){
            petShop.setPassword(Constants.USER_DEFAULT_PASSWORD);
        }
        // 如果名称为空，默认为 店主+账号

        if (StrUtil.isBlank(petShop.getName())) { // 密码为空时，默认密码为 11
            petShop.setName("店主" + petShop.getUsername());
        }

        petShop.setStatus("待提交");  // 默认状态为待审核
        petShop.setRole(RoleEnum.PETSHOP.name());
        petShopMapper.insert(petShop);
    }

    public void update(PetShop petShop) {
        petShopMapper.updateById(petShop);
    }

    public void deleteById(Integer id) {
        petShopMapper.deleteById(id);
    }

    public void deleteBatch(List<Integer> ids) {
        for(Integer id : ids){
            petShopMapper.deleteById(id);
        }
    }


    public Account login(Account account) {
        String username = account.getUsername();
        PetShop dbPetShop = petShopMapper.selectByUsername(username);
        if(dbPetShop == null){
            throw new CustomException("500","用户名不存在");
        }
        String password = account.getPassword();
        if(!dbPetShop.getPassword().equals(password)){
            throw new CustomException("500","密码错误");
        }
        return dbPetShop;
    }

    public void updatePassword(Account account) {
        Integer id = account.getId();
        PetShop petShop = this.selectById(id);
        if(!petShop.getPassword().equals(account.getPassword())){
            throw new CustomException("500","原密码错误");
        }
        petShop.setPassword(account.getNewPassword()); //传入新密码
        this.update(petShop);
    }

    // 认证 更新认证状态
    public void identify(PetShop petShop) {
        if(RoleEnum.PETSHOP.name().equals(petShop.getRole())){
            petShop.setStatus("待审核");
        }
        petShopMapper.updateById(petShop);
    }
}