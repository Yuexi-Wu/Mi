package com.mi.model.service;

import com.mi.model.bean.Product;
import com.mi.model.dao.ProductDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.*;

/**
 * Created by Alexander on 2018/7/21 下午10:16
 */
@Service
public class ProductService {

    @Autowired
    private ProductDAO productDAO;

    public List<Product> selectAllProducts(String productName, String scId, String page, String limit){
        Map<String, Object> map = new HashMap<>();
        if (productName != null && !productName.equals("")){
            map.put("productName", productName);
        }
        if (scId != null && !scId.equals("")){
            map.put("scId", Integer.parseInt(scId));
        }
        if (page != null && !page.equals("") && limit != null && !limit.equals("")){
            map.put("index", ((Integer.parseInt(page) - 1) * Integer.parseInt(limit)));
            map.put("limit", Integer.parseInt(limit));
        }
        return productDAO.selectAllProducts(map);
    }

    public int selectAllProductsCount(String productName, String scId){
        Map<String, Object> map = new HashMap<>();
        if (productName != null && !productName.equals("")){
            map.put("productName", productName);
        }
        if (scId != null && !scId.equals("")){
            map.put("scId", Integer.parseInt(scId));
        }
        return productDAO.selectAllProductsCount(map);
    }

    public void deleteProduct(int productId) {
        productDAO.deleteProduct(productId);
    }

    public void addProduct(Product product) {
        product.setProductTime(new Date());
        productDAO.addProduct(product);
    }

    public Product selectProductById(int productId) {
        return productDAO.selectProductById(productId);
    }

    public void updateProduct(Product product) {
        productDAO.updateProduct(product);
    }

    /*对商品进行排序*/
    public List<Product> selectProductSorted(Integer fcId, Integer scId, String productName, String sortway,
                                             String page, String limit) {
        List<Product> productList = new ArrayList<>();
        Map<String, Object> map = new HashMap<>();
        map = this.getMap(fcId,scId,productName,page,limit);
        switch (sortway) {
            case "priceDescendant"://价格降序
                productList = productDAO.selectProductSortedByPriceDesc(map);
                break;
            case "priceAscendant"://价格升序
                productList = productDAO.selectProductSortedByPriceAsc(map);
                break;
            case "time"://新品
                productList = productDAO.selectProductSortedByTime(map);
                break;
            case "sales"://热度
                productList = productDAO.selectProductSortedBySales(map);
                break;
            case "reviews"://评论数
                productList =productDAO.selectProductSortedByReviews(map);
                break;
            default:
                break;
        }
        return productList;
    }
    /*分页查询：根据商品的一二级分类精确查询或者商品名称模糊查询*/
    public List<Product> selectProductsByNFCPage(Integer fcId, Integer scId, String productName, String page, String limit){
        Map<String, Object> map = new HashMap<>();
        map = this.getMap(fcId,scId,productName,page,limit);
        List<Product> productList = productDAO.selectProductsByNFCPage(map);
        return productList;
    }
    /*返回查询商品总数*/
    public int selectPageNum(Integer fcId, Integer scId, String productName){
        Map<String, Object> map = new HashMap<>();
        if(fcId != null){
            map.put("fcId", fcId);
        }
        if(scId != null){
            map.put("scId", scId);
        }
        if(productName != null && !productName.equals("")){
            map.put("productName", productName);
        }
        int countnum = productDAO.selectPageNum(map);
        return countnum;
    }

    private Map<String,Object> getMap(Integer fcId, Integer scId, String productName, String page, String limit){
        Map<String, Object> map = new HashMap<>();
        if(fcId != null){
            map.put("fcId", fcId);
        }
        if(scId != null){
            map.put("scId", scId);
        }
        if(productName != null && !productName.equals("")){
            map.put("productName", productName);
        }
        if(page != null && !page.equals("") && limit != null && !limit.equals("")){
            map.put("index",(Integer.parseInt(page)-1)*Integer.parseInt(limit));
            map.put("limit",Integer.parseInt(limit));
        }
        return map;
    }

    /**
     * get all product id from small to large
     * @return sorted list of product ids
     * @author huang jiarui
     * @version 1.0
     */
    public List<Integer> getAllSortedProductId(){
        return productDAO.getAllSortedProductId();
    }

    /**
     * get products by product ids
     * @param productIds list of ids of products
     * @return list of products
     * @author huang jiarui
     * @version 1.0
     */
    public List<Product> getProductByIds(List<Integer> productIds){
        return productDAO.getProductByIds(productIds);
    }
}
