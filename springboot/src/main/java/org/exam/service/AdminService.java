package org.exam.service;

import cn.hutool.core.util.StrUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import jakarta.annotation.Resource;
import org.exam.common.RoleEnum;
import org.exam.entity.Account;
import org.exam.entity.Admin;
import org.exam.exception.CustomException;
import org.exam.mapper.AdminMapper;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AdminService {

    @Resource
    private AdminMapper adminMapper;

    public List<Admin> selectAll(Admin admin) {
        return adminMapper.selectAll(admin);
    }

    public Admin selectById(Integer id) {
        return adminMapper.selectById(id);

    }

    public PageInfo<Admin> selectPage(Admin admin, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum,pageSize);
        List<Admin> list=adminMapper.selectAll(admin);
        return PageInfo.of(list);
    }

    public void add(Admin admin) {
        String username=admin.getUsername();
        Admin dbAdmin = adminMapper.selectByUsername(username);
        if(dbAdmin != null){
            throw new CustomException("500","用户名已存在");
        }

        if(StrUtil.isBlank(admin.getName())){
            admin.setName("管理员"+admin.getUsername());
        }

        admin.setRole(RoleEnum.ADM.name());  //默认为ADM（管理）
        adminMapper.insert(admin);
    }

    public void update(Admin admin) {
        adminMapper.updateById(admin);
    }

    public void deleteById(Integer id) {
        adminMapper.deleteById(id);
    }

    public void deleteBatch(List<Integer> ids) {
        for(Integer id : ids){
            adminMapper.deleteById(id);
        }
    }

    //登录
    public Admin login(Account account){
        String username = account.getUsername();
        Admin dbAdmin = adminMapper.selectByUsername(username);
        if(dbAdmin == null){
            throw new CustomException("500","用户名不存在");
        }
        String password = account.getPassword();
        if(!dbAdmin.getPassword().equals(password)){
            throw new CustomException("500","密码错误");
        }
        return dbAdmin;
    }

    public void updatePassword(Account account) {
        Integer id = account.getId();
        Admin admin = this.selectById(id);
        if(!admin.getPassword().equals(account.getPassword())){
              throw new CustomException("500","原密码错误");
        }
        admin.setPassword(account.getNewPassword()); //传入新密码
        this.update(admin);
    }
}