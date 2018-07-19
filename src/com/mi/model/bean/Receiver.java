package com.mi.model.bean;

public class Receiver {
    private int receiverId;
    private String receiverName;
    private int receiverPhone;
    private String adProvince;
    private String adCity;
    private String adDetail;
    private int postcode;
    private String adLabel;
    private Account account;


    public int getReceiverId() {
        return receiverId;
    }

    public void setReceiverId(int receiverId) {
        this.receiverId = receiverId;
    }

    public String getReceiverName() {
        return receiverName;
    }

    public void setReceiverName(String receiverName) {
        this.receiverName = receiverName;
    }

    public int getReceiverPhone() {
        return receiverPhone;
    }

    public void setReceiverPhone(int receiverPhone) {
        this.receiverPhone = receiverPhone;
    }

    public String getAdProvince() {
        return adProvince;
    }

    public void setAdProvince(String adProvince) {
        this.adProvince = adProvince;
    }

    public String getAdCity() {
        return adCity;
    }

    public void setAdCity(String adCity) {
        this.adCity = adCity;
    }

    public String getAdDetail() {
        return adDetail;
    }

    public void setAdDetail(String adDetail) {
        this.adDetail = adDetail;
    }

    public int getPostcode() {
        return postcode;
    }

    public void setPostcode(int postcode) {
        this.postcode = postcode;
    }

    public String getAdLabel() {
        return adLabel;
    }

    public void setAdLabel(String adLabel) {
        this.adLabel = adLabel;
    }

    public Account getAccount() {
        return account;
    }

    public void setAccount(Account account) {
        this.account = account;
    }


}
