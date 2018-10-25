package com.lsy.dao.system.dict;

import com.lsy.entity.system.SysDict;

import java.util.List;

/**
 * .
 *
 * @author lsy
 * @create 2018-10-24 9:47
 */
public interface LocationDao {
    /**
     * 楼栋地址datagrid显示
     * */
    public List<SysDict> getLocations(SysDict dict);

    public Integer getCounts(SysDict dict);
    /**
     * 查询父楼栋最大id
     * */
    String queryMaxIdFather(String dictType);
    /**
     * 查询子楼栋最大id
     * */
    String queryMaxIdChild(String dictType);
    /**
     * 根据名称楼栋数量
     * */
    int queryLocationByName(SysDict sysDict);

    /**
     * 根据经纬度查询楼栋
     * */
    int queryLocationByLngLat(SysDict sysDict);

    /**
     * 新增楼栋
     * */
    int addLocation(SysDict sysDict);

    /**
     * 查询所有的父楼栋
     * */
    public List<SysDict> getFatherLocation();

    /**
     * 根据id查询楼栋信息
     * */
    SysDict getLocationById(String dictID);

    /**
     * 修改楼栋信息
     * */
    Integer updateLocation(SysDict sysDict);
}
