package com.lsy.service.system.dict;

import com.lsy.entity.system.EventType;

import java.util.List;

/**
 * .
 *
 * @author lsy
 * @create 2018-10-25 16:04
 */
public interface IEventService {
    /**
     * 获取eventType
     * */
    List<EventType> getEventTypes(EventType eventType);

    Integer getCounts(EventType eventType);
}
