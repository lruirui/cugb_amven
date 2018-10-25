package com.lsy.controller.system.dict;

import com.lsy.entity.system.EventType;
import com.lsy.entity.system.SysDict;
import com.lsy.service.system.dict.IEventService;
import com.lsy.utils.Grid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * .
 *
 * @author lsy
 * @create 2018-10-24 9:39
 * 事件类型管理
 */
@Controller
@RequestMapping("/system/dict/event")
public class EventController {

    @Autowired
    private IEventService eventService;
    private String prefix = "/system/dict";
    /**
     * 页面跳转
     * eventDatagrid
     * */
    @RequestMapping("/{page}")
    public String index(@PathVariable String page){
        return prefix+"/"+page;
    }
    /**
     * 事件数据显示
     * */
    @RequestMapping(value = "/datagrid",method = RequestMethod.POST)
    @ResponseBody
    public Object getEvents(EventType eventType) {
        Grid grid = new Grid();
        grid.setRows(eventService.getEventTypes(eventType));
        grid.setTotal(eventService.getCounts(eventType));
        return grid;
    }
}
