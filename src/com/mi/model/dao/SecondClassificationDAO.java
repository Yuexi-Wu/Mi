package com.mi.model.dao;

import com.mi.model.bean.SecondClassification;

import java.util.List;
import java.util.Map;

/**
 * Created by Alexander on 2018/7/22 上午11:15
 */
public interface SecondClassificationDAO {

    //通过一级分类ID，二级分类名称来获取二级分类数量
    public int selectAllScsCount(Map<String, Object> map);
    //通过一级分类ID，二级分类名称，页码和页数来获取二级分类集合
    public List<SecondClassification> selectAllScs(Map<String, Object> map);
    //通过二级分类ID删除一级分类
    public void deleteSc(int scId);
}
