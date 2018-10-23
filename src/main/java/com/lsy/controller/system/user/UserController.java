package com.lsy.controller.system.user;

import com.lsy.dao.system.user.UserDao;
import com.lsy.entity.system.User;
import com.lsy.service.system.IUserService;
import com.lsy.utils.Grid;
import com.lsy.utils.PageFilter;
import com.lsy.utils.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * .
 *
 * @author lsy
 * @create 2018-10-23 14:42
 * 普通用户管理
 */
@Controller
@RequestMapping("/system/user")
public class UserController {
    private String prifex = "/system/user";

    @Autowired
    private IUserService userService;
    @Autowired
    private UserDao userDao;

    /**
     * 页面跳转
     * */
    @RequestMapping("/{page}")
    public String userDatagrid(@PathVariable String page) {
        return prifex+"/"+page;
    }

    /**
     * 普通用户查询
     * */
    @RequestMapping("/getAll")
    @ResponseBody
    public Object getAll(User user, PageFilter pageFilter) {
        Grid grid = new Grid();
        grid.setRows(userService.getUsers(user));
        grid.setTotal( userService.getCount(user));
        return grid;
    }
    /**
     * 用户新增
     * */
    @RequestMapping("/addUser")
    @ResponseBody
    public Result addUser(User user) {
        return userService.addUser(user);
    }

    /**
     * 返回到修改页面
     * */
    @RequestMapping("/editUser/{stuEmpno}")
    public String editUser(@PathVariable String stuEmpno, Model map){
        User user = userService.getUserByStuEmpno(stuEmpno);
        map.addAttribute(user);
        return prifex+"/UserEdit";
    }
    /**
     * 修改用户
     * */
    @RequestMapping("/editUser")
    @ResponseBody
    public Result editUser(User user){
        return userService.editUser(user);
    }
    /**
     * 删除用户
     * */
    @RequestMapping("/deleteUser")
    @ResponseBody
    public Result deleteUser(String stuEmpno){
        return userService.deleteUser(stuEmpno);
    }
}
