package com.mi.model.dao;


import com.mi.model.bean.GroupBuying;
import com.mi.model.bean.GroupBuyingProduct;
import com.mi.model.bean.Receiver;
import org.apache.ibatis.annotations.Param;

import java.util.ArrayList;
import java.util.Date;
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
    /**
     * get latest group buying activity
     * @return latest group buying activity
     * @author huang jiarui
     * @version 1.0
     */
    public GroupBuying getLatestGroupBuying();
    /**
     * @param product_id
     * @return void
     * @description 更新订单
     */
    public void updateOrder(int product_id) throws Exception;

    /**
     * @param product_id
     * @return void
     * @description 更新团购订单
     */
    public void updateGroupOrder(int product_id) throws Exception;

    /**
     * @param product_id
     * @return int
     * @description 查询某种商品在订单中的数量
     */
    public int getOrderNum(int product_id) throws Exception;

    /**
     * @param today
     * @return GroupBuying
     * @description 获取后台发布的团购活动
     */
    public GroupBuying getGroupActivity(String today) throws Exception;

    /**
     * @param gbId
     * @return list
     * @description 获取某次活动的全部商品集合
     */
    public ArrayList<GroupBuyingProduct> getGroupProducts(int gbId) throws Exception;

    /**
     * @param gbp_id
     * @return product
     * @description 获取一个团购商品的全部
     */
    public GroupBuyingProduct getOneGbp(int gbp_id);

    /**
     * @param account_id
     * @return list
     * @description 获取在该小米账号下的全部收货人信息
     */
    public ArrayList<Receiver> getReceivers(int account_id) throws Exception;
    /**
     * @param account_id,postcode,receiver_name,receiver_phone,ad_province,ad_city,ad_detail,ad_label,ad_district
     * @param postcode
     * @return boolean
     * @description 添加新收货人信息
     */
    public Boolean addReceiver(@Param("receiver_id") int receiver_id, @Param("account_id") int account_id, @Param("postcode") String postcode, @Param("receiver_name") String receiver_name, @Param("receiver_phone") String receiver_phone, @Param("ad_province") String ad_province, @Param("ad_city") String ad_city, @Param("ad_detail") String ad_detail, @Param("ad_label") String ad_label, @Param("ad_district") String ad_district);

    /**
     * @param order_id,order_generation_time,product_id
     * @return boolean
     * @description 新添加一个团购订单
     */
    public Boolean addGroupOrder(@Param("order_id") String order_id, @Param("order_generation_time") Date order_generation_time, @Param("product_id") int product_id);

    /**
     * @param product_id
     * @return List
     * @description 根据商品id从团购订单中获取全部的Order_id集合
     */
    public List<String> getGroupOrderIds(int product_id);

    /**
     * @param gbp_id
     * @return Integer
     * @description 统计已经付款后的团购订单的数量
     */
    public Integer getBoughtGbpNum(int gbp_id);

    public int getAccountIdByOrderId(String orderId);
}
