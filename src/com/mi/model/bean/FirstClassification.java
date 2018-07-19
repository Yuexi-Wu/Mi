package com.mi.model.bean;

import java.util.List;

/**
 * Created by Alexander on 2018/7/19 下午12:55
 */
public class FirstClassification {

    private int fcId;//一级分类ID
    private String fcName;//一级分类名称
    private String fcDescription;//一级分类描述
    private List<SecondClassification> scs;//该一级分类下所有二级分类集合

    public int getFcId() {
        return fcId;
    }

    public void setFcId(int fcId) {
        this.fcId = fcId;
    }

    public String getFcName() {
        return fcName;
    }

    public void setFcName(String fcName) {
        this.fcName = fcName;
    }

    public String getFcDescription() {
        return fcDescription;
    }

    public void setFcDescription(String fcDescription) {
        this.fcDescription = fcDescription;
    }

    public List<SecondClassification> getScs() {
        return scs;
    }

    public void setScs(List<SecondClassification> scs) {
        this.scs = scs;
    }
}
