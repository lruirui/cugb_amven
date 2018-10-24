package com.lsy.entity.system;

import com.lsy.entity.system.User;
public class ServerUser extends User implements java.io.Serializable {

	private String location;
	private String locationName;
	private String servicesKills;
	private String level;
	private String levelName;
	private String tel;
	private String workRole;
	private String roleName;
	private String email;
	private String webchat;
	private String createDate;
	private String createBy;
	private String modifyDate;
	private String modifyBy;
	private String isEnable;
	private String type;//父级部门名称
	private String searchContent;
	private String stuNo;
	private String stuEmpnoTemp;
	private String lng;//经度
	private String lat;//纬度
	private String passWord;
	private String isEnableVal;
	private String deptName;
	private String deptId;//部门编号
	private String deptPid;//父级部门的id
	
	
	
	
	public String getDeptPid() {
		return deptPid;
	}
	public void setDeptPid(String deptPid) {
		this.deptPid = deptPid;
	}
	public String getDeptId() {
		return deptId;
	}
	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}
	public String getDeptName() {
		return deptName;
	}
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	public String getIsEnableVal() {
		return isEnableVal;
	}
	public void setIsEnableVal(String isEnableVal) {
		this.isEnableVal = isEnableVal;
	}
	public String getLng() {
		return lng;
	}
	public void setLng(String lng) {
		this.lng = lng;
	}
	public String getLat() {
		return lat;
	}
	public void setLat(String lat) {
		this.lat = lat;
	}
	public String getStuEmpnoTemp() {
		return stuEmpnoTemp;
	}
	public void setStuEmpnoTemp(String stuEmpnoTemp) {
		this.stuEmpnoTemp = stuEmpnoTemp;
	}
	public String getStuNo() {
		return stuNo;
	}
	public void setStuNo(String stuNo) {
		this.stuNo = stuNo;
	}
	public String getLocationName() {
		return locationName;
	}
	public void setLocationName(String locationName) {
		this.locationName = locationName;
	}
	public String getLevelName() {
		return levelName;
	}
	public void setLevelName(String levelName) {
		this.levelName = levelName;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getSearchContent() {
		return searchContent;
	}
	public void setSearchContent(String searchContent) {
		this.searchContent = searchContent;
	}

	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getServicesKills() {
		return servicesKills;
	}
	public void setServicesKills(String servicesKills) {
		this.servicesKills = servicesKills;
	}
	public String getLevel() {
		return level;
	}
	public void setLevel(String level) {
		this.level = level;
	}
	public String getWorkRole() {
		return workRole;
	}
	public void setWorkRole(String workRole) {
		this.workRole = workRole;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}
}
