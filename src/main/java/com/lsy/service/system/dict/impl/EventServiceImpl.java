package com.lsy.service.system.dict.impl;

import com.lsy.dao.system.dict.EventDao;
import com.lsy.entity.system.EventType;
import com.lsy.service.system.dict.IEventService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * .
 *
 * @author lsy
 * @create 2018-10-25 16:04
 */
@Service
@Transactional(rollbackFor = Exception.class)
public class EventServiceImpl implements IEventService{

    @Autowired
    private EventDao eventDao;
    /**
     * 获取eventTypes
     * */
    @Override
    public List<EventType> getEventTypes(EventType eventType) {
        //先获取所有的子事件类型
        List<EventType> eventTypes = eventDao.getChildEvent(eventType);
        for (EventType type : eventTypes) {
            //根据子id获取父事件
            EventType eventTyep = eventDao.getParentEventByid(type.getPid());
            //设置父事件属性
            String parentName = eventTyep.getEventName();
            Integer parentId = eventTyep.getEventId();
            type.setParentEvent(parentName);
            type.setParentEvnetId(parentId);
        }
        //获取所有父事件
        List<EventType> eventTypes1 = eventDao.getParentEvent(eventType);
        for (EventType type : eventTypes1) {
            type.setParentEventName("-");
        }
        //将父事件添加到子事件中
        eventTypes.addAll(eventTypes1);
        return eventTypes;
    }

    @Override
    public Integer getCounts(EventType eventType) {
        //获取子事件数量
        Integer count1 = eventDao.getChildCount(eventType);
        //获取去父事件数量
        Integer count2 = eventDao.getParentCount(eventType);
        return count1+count2;
    }
}
