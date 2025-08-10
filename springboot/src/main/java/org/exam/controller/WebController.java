package org.exam.controller;


import cn.hutool.core.date.DateField;
import cn.hutool.core.date.DateTime;
import cn.hutool.core.date.DateUtil;
import jakarta.annotation.Resource;
import org.exam.common.Result;
import org.exam.common.RoleEnum;
import org.exam.entity.Account;
import org.exam.entity.PetShop;
import org.exam.entity.User;
import org.exam.exception.CustomException;
import org.exam.service.AdminService;
import org.exam.service.PetShopService;
import org.exam.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.*;
import java.util.stream.Collectors;

@RestController
public class WebController {


    @GetMapping("/hello")
    public String hello() {
        return Result.success("Hello World!").toString();
    }


    @Autowired
    private PetShopService petShopService;

    @Resource
    private AdminService adminService;


    @Autowired
    private UserService userService;


    //    管理员/员工登录接口
    @PostMapping("/login")
    public Result login(@RequestBody Account account) {

        Account result = null;
        if(RoleEnum.ADM.name().equals(account.getRole())){
            result  = adminService.login(account);
        } else if(RoleEnum.PETSHOP.name().equals(account.getRole())){
            result = petShopService.login(account);
        }else if(RoleEnum.USER.name().equals(account.getRole())){
            result = userService.login(account);
        }else{
            throw new CustomException("500","非法输入");
        }
        return Result.success(result);

    }

    //    注册接口
    @PostMapping("/register")
    public Result register(@RequestBody Account account) {
        Account result = null;
        if(RoleEnum.PETSHOP.name().equals(account.getRole())){
            PetShop petShop = new PetShop();
            // 将Account对象中的数据映射到PetShop对象中
            petShop.setUsername(account.getUsername());
            petShop.setPassword(account.getPassword());
            // 调用服务层方法完成新增
            petShopService.add(petShop);
        }
        if(RoleEnum.USER.name().equals(account.getRole())){
            User user = new User();
            // 将Account对象中的数据映射到User对象中
            user.setUsername(account.getUsername());
            user.setPassword(account.getPassword());
            // 调用服务层方法完成新增
            userService.add(user);
        }
        return Result.success();

    }



    //修改密码接口
    @PutMapping("/updatePassword")
    public Result updatePassword(@RequestBody Account account) {
        if(RoleEnum.ADM.name().equals(account.getRole())){
            adminService.updatePassword(account);
        } else if (RoleEnum.PETSHOP.name().equals(account.getRole())){
            petShopService.updatePassword(account);
        } else if (RoleEnum.USER.name().equals(account.getRole())){
            userService.updatePassword(account);
        }

        return Result.success();


    }

}
