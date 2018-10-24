package com.lsy.service.system.dict.impl;

import com.lsy.dao.system.dict.LocationDao;
import com.lsy.entity.system.SysDict;
import com.lsy.service.system.dict.ILocationService;
import com.lsy.utils.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.util.List;

/**
 * .
 *
 * @author lsy
 * @create 2018-10-24 9:46
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class LocationServiceImpl implements ILocationService{

    @Autowired
    private LocationDao locationDao;
    /**
     * 条件查询locations
     * */
    @Override
    public List<SysDict> getLocations(SysDict dict) {
//        int begin = dict.getBegin();
//        begin = (dict.getPage()-1)*dict.getRows();
//        dict.setBegin(begin);
        return locationDao.getLocations(dict);

    }

    /**
     * 查询楼栋数量
     * */
    @Override
    public Integer getCounts(SysDict dict) {
        return locationDao.getCounts(dict);
    }

    /**
     * 新增楼栋
     * */
    @Override
    public Result addLocation(SysDict sysDict) {
        sysDict = initLocation(sysDict);
        //楼栋名校验
        boolean name = checkLocationName(sysDict);
        if(name) {
            return Result.fail("楼栋名已存在，请重新输入");
        }
        //经纬度校验
        boolean lng = checkLngLat(sysDict);
        if(lng) {
            return Result.fail("经纬度已存在请重新输入");
        }
        int count =  locationDao.addLocation(sysDict);
        if(count>0) {
            return Result.success("楼栋新增成功");
        }
        return Result.fail("楼栋新增失败");
    }

    @Override
    public Result editLocation(SysDict sysDict) {
        return null;
    }

    /**
     * 设置楼栋信息
     * */
    public SysDict initLocation(SysDict sysDict) {
        //todo 创建人设置
        //判断创建的是父楼栋还是子楼栋
        String localType = sysDict.getLocalType();
        if (localType.equals("father")) {
            sysDict.setDictType("BuildingArea");
            //设置父楼栋ID
            String maxId = locationDao.queryMaxIdFather(sysDict.getDictType());
            if(StringUtils.isEmpty(maxId)) {
                maxId = "1000001";
            } else {
                maxId = String.valueOf(Integer.valueOf(maxId)+1);
            }
            sysDict.setDictID(maxId);
        } else if (localType.equals("child")) {
            sysDict.setDictType("Building");
            //设置子楼栋ID
            String maxId = locationDao.queryMaxIdChild(sysDict.getDictType());
            if(StringUtils.isEmpty(maxId)) {
                maxId = "1";
            } else {
                maxId = String.valueOf(Integer.valueOf(maxId)+1);
            }
            sysDict.setDictID(maxId);
        }
        return sysDict;
    }
    /**
     * 楼栋名校验
     * */
    public boolean checkLocationName(SysDict sysDict) {
        int count = locationDao.queryLocationByName(sysDict);
        if(count>0) {
            return true;
        }
        return false;
    }
    /**
     * 经纬度校验
     * */
    public boolean checkLngLat(SysDict sysDict) {
        int count = locationDao.queryLocationByLngLat(sysDict);
        if(count>0) {
            return true;
        }
        return false;
    }
}
