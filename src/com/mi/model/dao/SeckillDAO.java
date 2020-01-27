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
    //通过秒杀活动Id获取秒杀活动对象
    Seckill selectSeckillById(int seckillId);
    //根据id获取唯一秒杀活动Seckill
    public Seckill getSeckillById(int seckillId);
    //获取今日正在进行和即将进行的秒杀活动集合
    public List<Seckill> getTodayRemainingSeckills();
    /**
     * get latest second kill activity
     * @return latest second kill activity
     * @author huang jiarui
     * @version 1.0
     */
    public Seckill getLatestSeckill();

}
