package com.lsy.entity.system;

import com.lsy.utils.PageFilter;

import java.sql.Timestamp;

/**
 * .
 *
 * @author lsy
 * @create 2018-10-23 15:02
 */
public class User extends PageFilter{
    private static final long serialVersionUID = 6159615613952892233L;

    private String stuEmpno;
    private String empName;
    private String dept;
    private String tel;
    private String webchat;
    private String ext;
    private String role;
    private String email;
    private String isEnable;
    private Timestamp createDate;
    private String createBy;
    private Timestamp modifyDate;
    private String modifyBy;
    private String roleName;
    private String passWord;

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public String getStuEmpno() {
        return stuEmpno;
    }

    public void setStuEmpno(String stuEmpno) {
        this.stuEmpno = stuEmpno;
    }

    public String getEmpName() {
        return empName;
    }

    public void setEmpName(String empName) {
        this.empName = empName;
    }

    public String getDept() {
        return dept;
    }

    public void setDept(String dept) {
        this.dept = dept;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public String getWebchat() {
        return webchat;
    }

    public void setWebchat(String webchat) {
        this.webchat = webchat;
    }

    public String getExt() {
        return ext;
    }

    public void setExt(String ext) {
        this.ext = ext;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getIsEnable() {
        return isEnable;
    }

    public void setIsEnable(String isEnable) {
        this.isEnable = isEnable;
    }

    public Timestamp getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Timestamp createDate) {
        this.createDate = createDate;
    }

    public String getCreateBy() {
        return createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy;
    }

    public Timestamp getModifyDate() {
        return modifyDate;
    }

    public void setModifyDate(Timestamp modifyDate) {
        this.modifyDate = modifyDate;
    }

    public String getModifyBy() {
        return modifyBy;
    }

    public void setModifyBy(String modifyBy) {
        this.modifyBy = modifyBy;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    public String getPassWord() {
        return passWord;
    }

    public void setPassWord(String passWord) {
        this.passWord = passWord;
    }
}
