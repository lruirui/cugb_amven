package com.lsy.entity.system;

import java.util.Date;

public class Role implements java.io.Serializable {
	
	private static final long serialVersionUID = 6159615613952892233L;
	
	/*private String roleID = "";//角色ID
	private String roleName = "";//角色名称
	private String isService = "";//是否是运维服务人员
	private String createBy = "";//建立人
	private String modifyBy = "";//修改人
	private Date createDate = null;//建立时间
	private Date modifyDate = null;//修改时间
	private String oldRoleID = "";//用于修改时，判断未修改的角色ID是否有服务人员及管理人员
	//列表显示时使用
	private String createByName;//创建者姓名
*/	private String roleID;//角色ID
	private String roleName;//角色名称
	private String isService;//是否是运维服务人员
	private String createBy;//建立人
	private String modifyBy;//修改人
	private String createDate;//建立时间
	private String modifyDate;//修改时间
	private String oldRoleID;//用于修改时，判断未修改的角色ID是否有服务人员及管理人员
	//列表显示时使用
	private String createByName;//创建者姓名
	public String getRoleID() {
		return roleID;
	}
	public void setRoleID(String roleID) {
		this.roleID = roleID;
	}
	public String getRoleName() {
		return roleName;
	}
	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}
	public String getIsService() {
		return isService;
	}
	public void setIsService(String isService) {
		this.isService = isService;
	}
	public String getCreateBy() {
		return createBy;
	}
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}
	public String getModifyBy() {
		return modifyBy;
	}
	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
	}
	public String getCreateDate() {
		if(createDate!=null){
			int n=createDate.indexOf(".");
			   if(n>0){
		          createDate=createDate.substring(0,n);
			  }
			}
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getModifyDate() {
		return modifyDate;
	}
	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}
	public String getOldRoleID() {
		return oldRoleID;
	}
	public void setOldRoleID(String oldRoleID) {
		this.oldRoleID = oldRoleID;
	}
	public String getCreateByName() {
		return createByName;
	}
	public void setCreateByName(String createByName) {
		this.createByName = createByName;
	}
	
}