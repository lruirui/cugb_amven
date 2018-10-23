package com.lsy.dao.system.user;

import com.lsy.entity.system.User;
import com.lsy.utils.PageFilter;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * .
 *
 * @author lsy
 * @create 2018-10-23 15:00
 */
public interface UserDao {
    /**
     * 根据条件查询用户
     * @param pageFilter
     * @return list
     * */
    public List<User> getUsers(PageFilter pageFilter);
    /**
     * 查询用户数量
     * */
    public Integer getCount(PageFilter pageFilter);

    /**
     *根据ID查询用户
     * */
    public Integer getUserByEmpno(String stuEmpno);

    /**
     * 增加用户
     * */
    Integer addUser(User user);

    public User queryUserByStuEmpno(String stuEmpno);

    public Integer updateUser(User user);

    public Integer deleteUser(String stuEmpno);
}
