package com.mi.model.dao;

import com.mi.model.bean.Seckill;

import java.util.List;
import java.util.Map;

/**
 * Created by Alexander on 2018/7/22 下午2:04
 */
public interface SeckillDAO {

    //通过开始时间和结束时间来获取秒杀活动集合
    public List<Seckill> selectAllSeckills(Map<String, Object> map);
    //通过开始时间和结束时间来获取秒杀活动数量
    public int selectAllSeckillsCount(Map<String, Object> map);
    //通过秒杀活动ID删除秒杀活动
    public void deleteSeckill(int seckillId);
    //添加秒杀活动
    void addSeckill(Seckill seckill);
}
