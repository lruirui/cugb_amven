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

    String queryMaxIdFather(String dictType);

    String queryMaxIdChild(String dictType);

    int queryLocationByName(SysDict sysDict);

    int queryLocationByLngLat(SysDict sysDict);

    int addLocation(SysDict sysDict);
}
