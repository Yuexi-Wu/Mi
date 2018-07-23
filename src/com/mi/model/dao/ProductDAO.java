package com.mi.model.dao;

import com.mi.model.bean.Product;

import java.util.List;
import java.util.Map;

/**
 * Created by Alexander on 2018/7/20 上午11:43
 */
public interface ProductDAO {
    //通过二级分类ID，商品名称，页码，页数来获取符合条件的商品集合
    public List<Product> selectAllProducts(Map<String, Object> map);
    //通过二级分类ID，商品名称来获取符合条件的商品数量
    public int selectAllProductsCount(Map<String, Object> map);
    public List<Product> selectProductsByScId(int scId);
    //通过商品ID删除商品
    public void deleteProduct(int productId);
    //添加商品
    public void addProduct(Product product);
    //通过商品ID获取商品
    Product selectProductById(int productId);
    //修改商品信息
    public void updateProduct(Product product);
}
