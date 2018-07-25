package com.mi.model.dao;

import com.mi.model.bean.GroupBuyingProduct;

import java.util.List;

/**
 * Created by Alexander on 2018/7/24 下午11:28
 */
public interface GroupBuyingProductDAO {
    //向表中批量插入团购商品项数据
    public void addGbps(List<GroupBuyingProduct> list);
}
