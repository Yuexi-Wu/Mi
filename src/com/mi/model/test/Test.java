package com.mi.model.test;

import com.mi.model.bean.Product;
import com.mi.model.dao.ProductDAO;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import java.io.IOException;
import java.io.Reader;
import java.sql.Connection;
import java.util.List;

/**
 * Created by Alexander on 2018/7/20 下午1:38
 */
public class Test {
    private static ThreadLocal<SqlSession> threadLocal = new ThreadLocal<SqlSession>();
    private static SqlSessionFactory sqlSessionFactory;
    static{
        try {
            Reader reader = Resources.getResourceAsReader("SqlMapConfig.xml");
            sqlSessionFactory = new SqlSessionFactoryBuilder().build(reader);
        } catch (IOException e) {
            e.printStackTrace();
            throw new RuntimeException(e);
        }
    }
    private Test() {}

    public static SqlSession getSqlSession(){
        SqlSession sqlSession = threadLocal.get();
        if(sqlSession == null){
            sqlSession = sqlSessionFactory.openSession();
            threadLocal.set(sqlSession);
        }
        return sqlSession;
    }

    public static void closeSqlSession(){
        SqlSession sqlSession = threadLocal.get();
        if(sqlSession != null){
            sqlSession.close();
            threadLocal.remove();
        }
    }

    public static void main(String[] args) {
        Connection conn = Test.getSqlSession().getConnection();
        System.out.println(conn!=null ? "连接成功" : "连接失败");
        ProductDAO dao = Test.getSqlSession().getMapper(ProductDAO.class);
        List<Product> products = dao.selectAllProducts();
        for (Product product: products){
            System.out.println(product);
        }
    }
}
