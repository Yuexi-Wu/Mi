package com.mi.model.bean;

import java.util.Date;

public class SeckillQueueStatus {
	private int sqsId;
	private Account account;
	private SeckillProduct seckillProduct;
	private int sqsStatus;
	private int sqsWaitCount;
	private Date sqsAcceptedTime;
	
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
	public SeckillProduct getSeckillProduct() {
		return seckillProduct;
	}
	public void setSeckillProduct(SeckillProduct seckillProduct) {
		this.seckillProduct = seckillProduct;
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
