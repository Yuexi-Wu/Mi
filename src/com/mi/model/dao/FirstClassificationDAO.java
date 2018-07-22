package com.mi.model.dao;

import com.mi.model.bean.FirstClassification;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * Created by Alexander on 2018/7/20 上午9:53
 */
public interface FirstClassificationDAO {

    //通过一级分类名称来获取符合条件的商品数量
    public int selectAllFcsCount(@Param("fcName") String fcName);
    //通过一级分类名称来获取符合条件的商品集合
    public List<FirstClassification> selectAllFcs(Map<String, Object> map);
    public FirstClassification selectFcById(int fcId);
    //通过一级分类ID删除一级分类
    public void deleteFc(int fcId);
}
