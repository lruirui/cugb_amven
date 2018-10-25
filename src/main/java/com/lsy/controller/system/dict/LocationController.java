package com.lsy.controller.system.dict;

/**
 * .
 *
 * @author lsy
 * @create 2018-10-24 9:36
 * 楼栋管理
 */

import com.lsy.entity.system.SysDict;
import com.lsy.service.system.dict.ILocationService;
import com.lsy.utils.Grid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/system/dict")
public class LocationController {
    @Autowired
    private ILocationService locationService;

    private String prefix = "/system/dict";
    /**
     * 页面跳转
     * */
    @RequestMapping("/{page}")
    public String index(@PathVariable String page){
        return prefix+"/"+page;
    }
    /**
     * 楼栋数据显示
     * */
    @RequestMapping(value = "/datagrid",method = RequestMethod.POST)
    @ResponseBody
    public Object getLocations(SysDict dict) {
        Grid grid = new Grid();
        grid.setRows(locationService.getLocations(dict));
        grid.setTotal(locationService.getCounts(dict));
        return grid;
    }
    /**
     * 新增楼栋
     * */
    @RequestMapping("/addLocation")
    @ResponseBody
    public Object addLocation(SysDict sysDict) {
        return locationService.addLocation(sysDict);
    }

    /**
     * 编辑页面跳转
     * */
    @RequestMapping("/editPage")
    @ResponseBody
    public String editLocationPage(String dictID, Model model) {
        SysDict location = locationService.getLocationById(dictID);
        model.addAttribute("location",location);
        return prefix+"editPage";
    }
    /**
     * 编辑楼栋
     * */
    @RequestMapping("/editLocation")
    @ResponseBody
    public Object editLocation(SysDict sysDict) {
        return locationService.editLocation(sysDict);
    }

    /**
     * 删除楼栋
     * */
    @RequestMapping("/deleteLocation")
    @ResponseBody
    public Object deleteLocation(String dictID) {
        return locationService.deleteLocationById(dictID);
    }

    /**
     * 楼栋查询
     * */
    @RequestMapping("/queryLocation")
    @ResponseBody
    public Grid queryLocation() {
        return null;
    }

    /**
     * 获取父楼栋
     * */
    @RequestMapping("/getFatherLocation")
    @ResponseBody
    public Object getChildLocation() {
        return locationService.getFatherLocation();
    }
}
