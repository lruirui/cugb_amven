package com.lsy.entity.system;

import com.lsy.utils.PageFilter;

public class SysDict extends PageFilter{
	
	private String dictType;	//字典类型
	private String dictID;		//字典明细ID
	private String dictName;	//字典名
	private String isEnable;	//是否启用
	private String isMain;
	private String createDate;
	private String createBy;
	private String modifyDate;
	private String modifyBy;
	private String oldDictID;
	private String lng;//经度
	private String lat;//纬度
	private String pid;//楼栋区域
	private String fatherLocal;//父级楼栋信息
	private String localType;//楼栋信息的类型,是父级东栋(比如说东区,北区),子级楼栋信息(比如说北区里面的教学楼)

	
	
	
	public String getLocalType() {
		return localType;
	}
	public void setLocalType(String localType) {
		this.localType = localType;
	}
	public String getFatherLocal() {
		return fatherLocal;
	}
	public void setFatherLocal(String fatherLocal) {
		this.fatherLocal = fatherLocal;
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
	public String getPid() {
		return pid;
	}
	public void setPid(String pid) {
		this.pid = pid;
	}


	public String getOldDictID() {
		return oldDictID;
	}
	public void setOldDictID(String oldDictID) {
		this.oldDictID = oldDictID;
	}
	public String getIsMain() {
		return isMain;
	}
	public void setIsMain(String isMain) {
		this.isMain = isMain;
	}
	public String getDictType() {
		return dictType;
	}
	public void setDictType(String dictType) {
		this.dictType = dictType;
	}
	public String getDictID() {
		return dictID;
	}
	public void setDictID(String dictID) {
		this.dictID = dictID;
	}
	public String getDictName() {
		return dictName;
	}
	public void setDictName(String dictName) {
		this.dictName = dictName;
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
		return modifyDate;
	}
	public void setModifyDate(String modifyDate) {
		this.modifyDate = modifyDate;
	}
	public String getModifyBy() {
		return modifyBy;
	}
	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
	}
}
