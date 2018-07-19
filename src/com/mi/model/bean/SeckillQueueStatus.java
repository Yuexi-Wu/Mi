package com.mi.model.bean;

import java.util.Date;

public class SeckillQueueStatus {
	int sqsId;
	Account account;
	SeckillProduct seckill_product;
	int sqsStatus;
	int sqsWaitCount;
	Date sqsAcceptedTime;
	
	public int getSqsId() {
		return sqsId;
	}
	public void setSqsId(int sqsId) {
		this.sqsId = sqsId;
	}
	public Account getAccount() {
		return account;
	}
	public void setAccount(Account account) {
		this.account = account;
	}
	public SeckillProduct getSeckill_product() {
		return seckill_product;
	}
	public void setSeckill_product(SeckillProduct seckill_product) {
		this.seckill_product = seckill_product;
	}
	public int getSqsStatus() {
		return sqsStatus;
	}
	public void setSqsStatus(int sqsStatus) {
		this.sqsStatus = sqsStatus;
	}
	public int getSqsWaitCount() {
		return sqsWaitCount;
	}
	public void setSqsWaitCount(int sqsWaitCount) {
		this.sqsWaitCount = sqsWaitCount;
	}
	public Date getSqsAcceptedTime() {
		return sqsAcceptedTime;
	}
	public void setSqsAcceptedTime(Date sqsAcceptedTime) {
		this.sqsAcceptedTime = sqsAcceptedTime;
	}
}
