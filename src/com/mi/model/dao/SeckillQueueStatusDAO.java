package com.mi.model.dao;

import com.mi.model.bean.SeckillQueueStatus;

public interface SeckillQueueStatusDAO {
    public SeckillQueueStatus getSqsById(int sqsId);
    public SeckillQueueStatus getCurrentSqsByAccountId(int accountId);
    public void addSeckillQueueStatus(SeckillQueueStatus sqs);
    public void updateWaitCount(SeckillQueueStatus sqs);
    public void updateSqsStatus(SeckillQueueStatus sqs);
}
