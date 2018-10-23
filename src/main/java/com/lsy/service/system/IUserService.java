package com.lsy.service.system;

import com.lsy.entity.system.User;
import com.lsy.utils.PageFilter;
import com.lsy.utils.Result;

import java.util.List;

/**
 * .
 *
 * @author lsy
 * @create 2018-10-23 14:55
 */
public interface IUserService {

    public List<User> getUsers(User user);

    public Integer getCount(User user);

    public Result addUser(User user);
}
