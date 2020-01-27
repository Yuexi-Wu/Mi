package com.mi.controller;

import com.mi.model.bean.Product;
import com.mi.model.dao.ProductDAO;
import com.mi.model.service.ProductService;
import com.mi.model.tools.CusMethod;
import com.sun.deploy.net.HttpResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by Alexander on 2018/7/20 下午2:21
 */

@Controller
public class ProductController {

    @Autowired
    private ProductService service;

    @RequestMapping("getAllProducts")
    @ResponseBody
    public Map<String, Object> getAllProducts(String productName, String scId, String page, String limit){
        System.out.println(productName + "---" + scId + "---" + page + "---" + limit);
        Map<String, Object> result = new HashMap<>();
        result.put("code", 0);
        result.put("msg", "");
        result.put("count", service.selectAllProductsCount(productName, scId));
        List<Product> products = service.selectAllProducts(productName, scId, page, limit);
        result.put("data", products);
        return result;
    }

    @RequestMapping("deleteProduct")
    @ResponseBody
    public String deleteProduct(int productId){
        service.deleteProduct(productId);
        return "success";
    }

    @RequestMapping("addProduct")
    @ResponseBody
    public String addProduct(Product product){
        if (product.getScId() == 0){
            return "sc";
        }else if (product.getProductName() == null || product.getProductName().equals("")){
            return "name";
        }else if (product.getProductPrice() == null || product.getProductPrice().equals("")){
            return "price";
        }else if (product.getProductMax() == null || product.getProductMax().equals("")){
            return "max";
        }else if (product.getProductUrl() == null || product.getProductUrl().equals("")){
            return "url";
        }
        product.setProductId(CusMethod.randomId());
        service.addProduct(product);
        return "success";

    }

    @RequestMapping("getProductById")
    public String getProductById(int productId, Model model){
        Product product = service.selectProductById(productId);
        model.addAttribute("product", product);
        return "productEdit";
    }

    @RequestMapping("updateProduct")
    @ResponseBody
    public String updateProduct(Product product){
        if (product.getScId() == 0){
            return "sc";
        }else if (product.getProductName() == null || product.getProductName().equals("")){
            return "name";
        }else if (product.getProductPrice() == null || product.getProductPrice().equals("")){
            return "price";
        }else if (product.getProductMax() == null || product.getProductMax().equals("")){
            return "max";
        }else if (product.getProductUrl() == null || product.getProductUrl().equals("")){
            return "url";
        }
        service.updateProduct(product);
        return "success";

    }

    /*根据商品的一二级分类精确查询或者商品名称模糊查询,若存在sortway，则对此商品列表进行排序
    @param fcId scId productName 查询条件
     */
    @RequestMapping("selectData")
    public @ResponseBody List<Product> selectData(String scId,String fcId, String productName, String sortway, String page, String limit) {
        Integer fcIdOut;
        Integer scIdOut;
        try {
            productName = URLDecoder.decode(productName,"UTF-8");
        } catch (UnsupportedEncodingException e) {
        }
        if(page==null || page.equals(" ")){
            page="1";
        }
        if(limit==null || limit.equals(" ")){
            limit="24";
        }
        if(fcId==null || fcId.equals("")){
            fcIdOut = null;
        }else{
            fcIdOut=Integer.parseInt(fcId);
        }
        if(scId==null || scId.equals("")){
            scIdOut = null;
        }else{
            scIdOut=Integer.parseInt(scId);
        }
        List<Product> productList = null;

        if(sortway!=null && !sortway.equals("")) {
            productList = service.selectProductSorted(fcIdOut, scIdOut, productName, sortway,page, limit);
        }else{
            productList = service.selectProductsByNFCPage(fcIdOut, scIdOut, productName, page, limit);
        }
        return productList;
    }
    /*处理从前台获取来的查询所需的参数值
     * @param scId 二级分类名称
     * @param fcId 一级分类名称
     *@param productName 商品名称
     *@param sortway 排序方式名称
     *@param priceSortToggle 价格升序降序符号 0是降序 1是升序 默认降序
     *
     * */
    @RequestMapping("selectProduct")
    public String selectProduct(Model model, String scId, String fcId, String productName, String sortway,String priceSortToggle){
        model.addAttribute("scId",scId);
        model.addAttribute("fcId",fcId);
        model.addAttribute("productName",productName);
        model.addAttribute("sortway",sortway);
        model.addAttribute("priceSortToggle",priceSortToggle);
        System.out.println("_______________"+productName);
        return "productList";
    }

    /*返回查询商品数量countnum*/
    @RequestMapping("selectPageCount")
    public @ResponseBody int selectPageCount(String fcId, String scId, String productName){
        Integer fcIdOut;
        Integer scIdOut;
        if(fcId==null || fcId.equals("")){
            fcIdOut = null;
        }else{
            fcIdOut=Integer.parseInt(fcId);
        }
        if(scId==null || scId.equals("")){
            scIdOut = null;
        }else{
            scIdOut=Integer.parseInt(scId);
        }
        int countnum = service.selectPageNum(fcIdOut, scIdOut, productName);
        return countnum;
    }
}
