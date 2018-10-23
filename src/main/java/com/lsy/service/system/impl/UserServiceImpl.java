package com.lsy.service.system.impl;

import com.lsy.dao.system.user.UserDao;
import com.lsy.entity.system.User;
import com.lsy.service.system.IUserService;
import com.lsy.utils.PageFilter;
import com.lsy.utils.Result;
import com.lsy.utils.TimeUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * .
 *
 * @author lsy
 * @create 2018-10-23 15:34
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class UserServiceImpl implements IUserService{

    @Autowired
    private UserDao userDao;
    @Override
    public List<User> getUsers(User user) {
        List<User> users = userDao.getUsers(user);
        return users;
    }

    @Override
    public Integer getCount(User user) {
        return userDao.getCount(user);
    }

    @Override
    public Result addUser(User user) {
        //判断账号是否存在
        if(checkEmpno(user)) {
            return Result.fail("您输入的用户账号已存在，请重新输入");
        }
        //todo 暂时先写为定值
        user.setCreateBy("张三");
        user.setCreateDate(TimeUtils.getCurrentTime());
        user.setModifyDate(TimeUtils.getCurrentTime());
        userDao.addUser(user);
        return Result.success("新增用户成功");
    }

    /**
     * 判断账号是否存在
     * */
    public boolean checkEmpno(User user) {
        Integer count = userDao.getCount(user);
        if(count>0) {
            return true;
        }
        return false;
    }
}
