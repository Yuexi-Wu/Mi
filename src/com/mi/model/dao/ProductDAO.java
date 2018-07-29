package com.mi.model.dao;

import com.mi.model.bean.Product;

import java.util.List;
import java.util.Map;

/**
 * Created by Alexander on 2018/7/20 上午11:43
 */
public interface ProductDAO {
    //添加商品
    public void addProduct(Product product);
    //通过商品ID删除商品
    public void deleteProduct(int productId);
    //修改商品信息
    public void updateProduct(Product product);
    //通过二级分类ID，商品名称，页码，页数来获取符合条件的商品集合
    public List<Product> selectAllProducts(Map<String, Object> map);
    //通过二级分类ID，商品名称来获取符合条件的商品数量
    public int selectAllProductsCount(Map<String, Object> map);
    //通过商品名称获取商品集合 戴
    public List<Product> selectProductsByName(String name);
    //通过商品名称，一级分类，二级分类去查询商品集合 王
    public List<Product> selectProductsByNFC(Map<String, Object> map);
    //通过商品ID获取商品
    Product selectProductById(int productId);
    //通过商品名称，颜色，版本，尺寸来获取商品 戴
    public Product selectProductByNCVS(Product product);
    //通过商品ID增加商品销量
    public void updateProductSales(Map<String, Object> map);
    //通过index和limit两个属性来获取按照销量排行的商品集合
    List<Product> getProductsOrderedBySale(Map<String,Integer> map);
}
