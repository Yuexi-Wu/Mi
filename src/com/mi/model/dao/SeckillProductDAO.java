package com.mi.model.dao;

import com.mi.model.bean.SeckillProduct;

import java.util.List;

/**
 * Created by Alexander on 2018/7/24 下午8:27
 */
public interface SeckillProductDAO {

    //向表中批量插入秒杀商品项数据
    public void addSps(List<SeckillProduct> list);
    //根据id获取唯一秒杀商品
    public SeckillProduct getSeckillProductById(int spId);
    //根据秒杀活动id获取在该秒杀活动下的秒杀商品
    public List<SeckillProduct> getSeckillProductsBySeckillId(int seckillId);
    //获取该秒杀商品已售出的量（包括排队成功但未付款的量）
    public int getBoughtCount(int spId);
}
