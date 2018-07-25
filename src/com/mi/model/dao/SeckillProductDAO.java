package com.mi.model.dao;

import com.mi.model.bean.SeckillProduct;

import java.util.List;

/**
 * Created by Alexander on 2018/7/24 下午8:27
 */
public interface SeckillProductDAO {

    //向表中批量插入秒杀商品项数据
    public void addSps(List<SeckillProduct> list);
}
