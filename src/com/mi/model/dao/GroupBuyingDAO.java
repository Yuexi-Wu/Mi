package com.mi.model.dao;


import com.mi.model.bean.GroupBuying;
import com.mi.model.bean.GroupBuyingProduct;

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
    //通过团购活动ID删除团购活动
    public void deleteGb(int gbId);
    //添加团购活动
    void addGb(GroupBuying gb);
    //通过团购活动ID获取团购活动
    public GroupBuying selectGbById(int gbId);
}
