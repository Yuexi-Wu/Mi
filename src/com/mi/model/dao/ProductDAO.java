package com.mi.model.dao;

import com.mi.model.bean.Descripe;
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
    List<Product> getProductsOrderedBySale(Map<String, Integer> map);
    //通过商品名称，型号，尺寸查询商品颜色 戴
    List<String> selectProductColor(Product product);
    //通过商品名称查询商品尺寸 戴
    List<Descripe> selectProductSize(String productName);
    //通过商品名称查询商品型号 戴
    List<Descripe> selectProductVersion(String productName);
    //通过商品颜色查询商品图片 戴
    List<String> selectProductPic(Map<String, Object> map);
    //查询热销商品 戴
    List<Product> getProductInHotSale(Map<String, Object> map);
    //通过商品名字获得同名最低价商品 戴
    List<Product> getLowestPrice(String prodctName);
    /*分页查询：根据商品的一二级分类精确查询或者商品名称模糊查询*/
    public List<Product> selectProductsByNFCPage(Map<String, Object> map);

    /*返回查询结果商品总数*/
    public int selectPageNum(Map<String, Object> map);

    /*得到根据评论数排序后的商品列表*/
    public List<Product> selectProductSortedByReviews(Map<String, Object> map);

    /*按照销售数量进行排序*/
    public List<Product> selectProductSortedBySales(Map<String, Object> map);

    /*按照价格降序排序*/
    public List<Product> selectProductSortedByPriceDesc(Map<String, Object> map);

    /*按照价格升序排序*/
    public List<Product> selectProductSortedByPriceAsc(Map<String, Object> map);

    /*按照上架时间最新排序*/
    public List<Product> selectProductSortedByTime(Map<String, Object> map);
    /**
     * get all product id from small to large
     * @return sorted list of product ids
     * @author huang jiarui
     * @version 1.0
     */
    public List<Integer> getAllSortedProductId();

    /**
     * get products by product ids
     * @param productIds list of ids of products
     * @return list of products
     * @author huang jiarui
     * @version 1.0
     */
    public List<Product> getProductByIds(List<Integer> productIds);

    int selectFcByProductId(int productId);
}
