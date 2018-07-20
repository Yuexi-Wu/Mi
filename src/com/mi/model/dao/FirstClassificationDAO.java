package com.mi.model.dao;

import com.mi.model.bean.FirstClassification;

import java.util.List;

/**
 * Created by Alexander on 2018/7/20 上午9:53
 */
public interface FirstClassificationDAO {

    public List<FirstClassification> selectAllFc();
    public FirstClassification selectFcById(int fcId);
}
