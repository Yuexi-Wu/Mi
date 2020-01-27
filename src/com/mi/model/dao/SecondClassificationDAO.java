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
    //通过二级分类ID删除二级分类
    public void deleteSc(int scId);
    //添加二级分类
    public void addSc(SecondClassification sc);
    //通过ID获取二级分类
    public SecondClassification selectScById(int scId);
    //修改二级分类信息
    public void updateSc(SecondClassification sc);
    /*根据一级分类返回全部二级分类*/
    public List<SecondClassification> selectScByFc(int fcId);
    /**
     * get all second classifications by id of first classification
     * @param fcId id of first classification
     * @return list of second classifications
     * @author huang jiarui
     * @version 1.0
     */
    public List<SecondClassification> getSecondClassificationByFcId(Integer fcId);
}
