package com.lsy.utils;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * .
 *
 * @author lsy
 * @create 2018-10-23 17:31
 */
public class TimeUtils {
    public static Timestamp getCurrentTime() {
        Date time = new Date();
        SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Timestamp createTime = Timestamp.valueOf(format.format(time.getTime()));
        return createTime;
    }
}
