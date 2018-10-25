package com.lsy.dao.system.dict;

import com.lsy.entity.system.EventType;

import java.util.List;

/**
 * .
 *
 * @author lsy
 * @create 2018-10-25 16:07
 */
public interface EventDao {

    List<EventType> getChildEvent(EventType eventType);

    EventType getParentEventByid(String pid);

    List<EventType> getParentEvent(EventType eventType);

    /**
     * 获取子事件数量
     * */
    Integer getChildCount(EventType eventType);

    /**
     * 获取父事件数量
     * */
    Integer getParentCount(EventType eventType);
}
