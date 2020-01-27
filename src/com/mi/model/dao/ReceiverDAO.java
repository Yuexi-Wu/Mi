package com.mi.model.dao;

import com.mi.model.bean.Receiver;

import java.util.List;

public interface ReceiverDAO {

    //得到账户所有收货地址
    public List<Receiver> selectReceiverByAccount(int accountId);

    //添加收货地址
    public void addReceiver(Receiver receiver);

    //修改收货地址
    public void updateReceiver(Receiver receiver);

    //删除收货地址
    public void deleteReceiver(int receiverId);

    //验证收货地址是否重复
    public Receiver validateReceiver(Receiver receiver);

    //通过收货地址Id查询售后地址
    public Receiver selectReceiverById(int receiverId);
}
