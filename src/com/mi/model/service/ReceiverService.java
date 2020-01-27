package com.mi.model.service;

import com.mi.model.bean.Receiver;
import com.mi.model.dao.ReceiverDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ReceiverService {

    @Autowired
    private ReceiverDAO receiverDAO;

    public List<Receiver> selectReceiverByAccount(int accountId){
        List<Receiver> r = receiverDAO.selectReceiverByAccount(accountId);
        return r;
    }

    public boolean findReceiver(Receiver receiver){
        Receiver r = receiverDAO.validateReceiver(receiver);
        if(r==null){
            return false;
        }else {
            return true;
        }
    }

    public void saveReceiver(Receiver receiver){
        receiverDAO.addReceiver(receiver);
    }

    public void updateReceiver(Receiver receiver){
        receiverDAO.updateReceiver(receiver);
    }

    public void deleteReceiver(int receiverId){
        receiverDAO.deleteReceiver(receiverId);
    }


}