package com.lsy.service.system.dict;

import com.lsy.entity.system.SysDict;
import com.lsy.utils.Result;

import java.util.List;

/**
 * .
 *
 * @author lsy
 * @create 2018-10-24 9:45
 */
public interface ILocationService {

    public List<SysDict> getLocations(SysDict dict);

    public Integer getCounts(SysDict dict);

    public Result addLocation(SysDict sysDict);

    public Result editLocation(SysDict sysDict);
}
