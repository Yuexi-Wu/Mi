package com.mi.model.dao;

import com.mi.model.bean.Account;
import com.mi.model.bean.Confiditiality;
import com.mi.model.bean.FavouriteItem;
import com.mi.model.bean.Receiver;
import java.util.List;
import java.util.Map;


public interface AccountDAO {

    //注册之前先绑定一个手机号
    public void addTelephone(Account account);

    //注册账户名和密码
    public void addAccount(Account account);

    //注册个人信息
    public void addInfo(Account account);

    //注册账户头像
    public void addAvatar(Account account);

    //注册新用户
    public void registAccount(Account account);

    //检验用户名是否重复
    public String validateAccountName(String accountName);

    //验证用户名和电话是否有冲突
    public String validateNameAndPhone(String accountName);

    //检验用户名和邮箱是否有冲突
    public String validateNameAndEmail(String accountName);

    //修改密码时验证原密码是否正确
    public Account verifyPassword(Account account);

    //通过id得到账户
    public Account getAccountById(int accountId);

    //查看喜欢的商品
    public List<FavouriteItem> checkFavouriteById(int accountId);

    //登录时验证用户名密码是否有效
    public Account validateAccount(Account account);

    //绑定新邮箱
    public void updateEmail(Account account);

    //更新密码
    public void updatePassword(Account account);

    //更改账户信息
    public void updateAccountInfo(Account account);

    //删除喜欢的商品
    public void deleteFavourite(int favourId);

    //检验是否存在此电话号码
    public String findTelephone(String telephone);

    //检验是否存在此邮箱
    public String findEmail(String email);

    //检验是否存在此用户名
    public String findAccountName(String accountName);

    //得到所有账户ID
    public List<String> getAllAccountId();

    //设置密保问题
    public void addConfiditiality(Confiditiality confiditiality);

    //得到所有账户id
    public List<Integer> selectAllAccountsId();

    //修改头像
    public void updateAvatar(Account account);

    //得到待支付商品数量
    public int getPayingNum(int accountId);

    //得到待收货商品数量
    public int getShippingNum(int accountId);

    //得到未评价商品数
    public int getUncommentedNum(int accountId);

    //w
    public Account findAccountByName(Account account);

    //获取总用户数量 zkn
    public int getAllAccountsCount();

    /**
     * get all account id from small to large
     * @return the sorted list of account id
     * @author huang jiarui
     * @version 1.0
     */
    public List<Integer> getAllSortedAccountId();

    /*添加到我的喜欢*/
    public void addToFavorite(Map<String,Object> map);

}