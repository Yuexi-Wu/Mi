package com.mi.model.dao;


import com.mi.model.bean.GroupBuying;

import java.util.List;
import java.util.Map;

/**
 * Created by Alexander on 2018/7/22 下午4:47
 */
public interface GroupBuyingDAO {
    //通过开始时间和结束时间来获取团购活动集合
    public List<GroupBuying> selectAllGbs(Map<String, Object> map);
    //通过开始时间和结束时间来获取团购活动数量
    public int selectAllGbsCount(Map<String, Object> map);
    //通过秒杀活动ID删除团购活动
    public void deleteGb(int gbId);
}
