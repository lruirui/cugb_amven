package com.lsy.entity.system;

import com.lsy.utils.PageFilter;

public class EventType extends PageFilter{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private Integer eventId;//事件类型编号
	private String eventName;//事件名称
	private String isEnable;//是否启用
	private String createDate;//创建时间
	private String createBy;//创建人
	private String ModifyDate;//修改时间
	private String ModifyBy;//修改人
	private String pid;//父级事件的Id
	private String parentEvent;//父级事件类型
	private String menuLevel;//菜单级别
	private String childMenuLevelId;//如果是子类型的话，这个就是它的父事件的id
	private Integer parentEvnetId;
	private String parentEventName;
	private String temp;
	
	
	
	public String getTemp() {
		return temp;
	}
	public void setTemp(String temp) {
		this.temp = temp;
	}
	public Integer getParentEvnetId() {
		return parentEvnetId;
	}
	public void setParentEvnetId(Integer parentEvnetId) {
		this.parentEvnetId = parentEvnetId;
	}
	public String getParentEventName() {
		return parentEventName;
	}
	public void setParentEventName(String parentEventName) {
		this.parentEventName = parentEventName;
	}
	

	public Integer getEventId() {
		return eventId;
	}
	public void setEventId(Integer eventId) {
		this.eventId = eventId;
	}
	public String getEventName() {
		return eventName;
	}
	public void setEventName(String eventName) {
		this.eventName = eventName;
	}
	public String getIsEnable() {
		return isEnable;
	}
	public void setIsEnable(String isEnable) {
		this.isEnable = isEnable;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getCreateBy() {
		return createBy;
	}
	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}
	public String getModifyDate() {
		return ModifyDate;
	}
	public void setModifyDate(String modifyDate) {
		ModifyDate = modifyDate;
	}
	public String getModifyBy() {
		return ModifyBy;
	}
	public void setModifyBy(String modifyBy) {
		ModifyBy = modifyBy;
	}
	public String getPid() {
		return pid;
	}
	public void setPid(String pid) {
		this.pid = pid;
	}
	public String getParentEvent() {
		return parentEvent;
	}
	public void setParentEvent(String parentEvent) {
		this.parentEvent = parentEvent;
	}
	public String getMenuLevel() {
		return menuLevel;
	}
	public void setMenuLevel(String menuLevel) {
		this.menuLevel = menuLevel;
	}
	public String getChildMenuLevelId() {
		return childMenuLevelId;
	}
	public void setChildMenuLevelId(String childMenuLevelId) {
		this.childMenuLevelId = childMenuLevelId;
	}
	
	
	
	
	

}
