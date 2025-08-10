package org.exam.service;

import cn.hutool.core.util.StrUtil;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import jakarta.annotation.Resource;
import org.exam.common.RoleEnum;
import org.exam.entity.Account;
import org.exam.entity.User;
import org.exam.exception.CustomException;
import org.exam.mapper.UserMapper;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserService {

    @Resource
    private UserMapper userMapper;

    public List<User> selectAll(User user) {
        return userMapper.selectAll(user);
    }

    public User selectById(Integer id) {
        return userMapper.selectById(id);

    }

    public PageInfo<User> selectPage(User user, Integer pageNum, Integer pageSize) {
        PageHelper.startPage(pageNum,pageSize);
        List<User> list=userMapper.selectAll(user);
        return PageInfo.of(list);
    }

    public void add(User user) {
        String username=user.getUsername();
        User dbUser = userMapper.selectByUsername(username);
        if(dbUser != null){
            throw new CustomException("500","用户名已存在");
        }

        if(StrUtil.isBlank(user.getName())){
            user.setName("用户"+user.getUsername());
        }

        user.setRole(RoleEnum.USER.name());  //默认为user（普通用户）
        userMapper.insert(user);
    }

    public void update(User user) {
        userMapper.updateById(user);
    }

    public void deleteById(Integer id) {
        userMapper.deleteById(id);
    }

    public void deleteBatch(List<Integer> ids) {
        for(Integer id : ids){
            userMapper.deleteById(id);
        }
    }

    //登录
    public User login(Account account){
        String username = account.getUsername();
        User dbUser = userMapper.selectByUsername(username);
        if(dbUser == null){
            throw new CustomException("500","用户名不存在");
        }
        String password = account.getPassword();
        if(!dbUser.getPassword().equals(password)){
            throw new CustomException("500","密码错误");
        }
        return dbUser;
    }

    public void updatePassword(Account account) {
        Integer id = account.getId();
        User user = this.selectById(id);
        if(!user.getPassword().equals(account.getPassword())){
              throw new CustomException("500","原密码错误");
        }
        user.setPassword(account.getNewPassword()); //传入新密码
        this.update(user);
    }
}