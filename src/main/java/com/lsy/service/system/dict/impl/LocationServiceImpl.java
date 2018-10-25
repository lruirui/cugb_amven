package com.lsy.service.system.dict.impl;

import com.lsy.dao.system.dict.LocationDao;
import com.lsy.entity.system.SysDict;
import com.lsy.service.system.dict.ILocationService;
import com.lsy.utils.Result;
import com.lsy.utils.TimeUtils;
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
        //todo 创建人设置
        //判断增加的类型
        String localType = sysDict.getLocalType();
        if("father".equals(localType)) {
            //新增父楼栋
            return addFatherLocation(sysDict);
        }
            //新增子楼栋
          return  addChildLocation(sysDict);


    }

    private Result addChildLocation(SysDict sysDict) {
        sysDict.setDictType("Building");
        //设置子楼栋ID
        String maxId = locationDao.queryMaxIdChild(sysDict.getDictType());
        if(StringUtils.isEmpty(maxId)) {
            maxId = "1";
        } else {
            maxId = String.valueOf(Integer.valueOf(maxId)+1);
        }
        sysDict.setDictID(maxId);
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
        //新增楼栋
        int count =  locationDao.addLocation(sysDict);
        if(count>0) {
            return Result.success("楼栋新增成功");
        }
        return Result.fail("楼栋新增失败");
    }

    /**
     * 增加父楼栋
     * */
    private Result addFatherLocation(SysDict sysDict) {
        sysDict.setDictType("BuildingArea");
        //设置父楼栋ID
        String maxId = locationDao.queryMaxIdFather(sysDict.getDictType());
        if(StringUtils.isEmpty(maxId)) {
            maxId = "1000001";
        } else {
            maxId = String.valueOf(Integer.valueOf(maxId)+1);
        }
        sysDict.setDictID(maxId);
        //楼栋名校验
        boolean name = checkLocationName(sysDict);
        if(name) {
            return Result.fail("该区域名已存在，请重新输入");
        }
        int count =  locationDao.addLocation(sysDict);
        if(count>0) {
            return Result.success("区域新增成功");
        }
        return Result.fail("区域新增失败");
    }

    /**
     * 删除楼栋
     * */
    @Override
    public Result deleteLocationById(String dictID) {
        //todo 判断楼栋是否被引用
        return null;
    }

    @Override
    public Result editLocation(SysDict sysDict) {
        //todo 获取编辑人员
        sysDict.setModifyDate(TimeUtils.getCurrentTime1());
        //todo 楼栋信息校验
        Integer count = locationDao.updateLocation(sysDict);
        if(count>0) {
            return Result.success("楼栋修改成功");
        }
        return Result.fail("楼栋修改失败");
    }

    /**
     * 获取父楼栋
     * */
    @Override
    public Result getFatherLocation() {
        List<SysDict> fatherLocation = locationDao.getFatherLocation();
        if(fatherLocation.size()==0) {
            return Result.fail("当前没有父楼栋");
        }
        return Result.success(fatherLocation);
    }
    /**
     * 根据id获取楼栋信息
     * */
    @Override
    public SysDict getLocationById(String dictID) {
        //todo 获取编辑人员
        return locationDao.getLocationById(dictID);
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
