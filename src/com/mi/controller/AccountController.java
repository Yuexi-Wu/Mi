package com.mi.controller;

import com.mi.model.bean.*;
import com.mi.model.service.AccountService;
import com.mi.model.tools.CusMethod;
import com.mi.model.tools.Email;
import com.mi.model.tools.Md5Utils;
import com.mi.model.tools.ParameterCheck;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.imageio.ImageIO;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import static com.mi.model.tools.CheckCode.drawBackground;
import static com.mi.model.tools.CheckCode.drawRands;
import static com.mi.model.tools.CheckCode.generateCheckCode;

@Controller
public class AccountController {

    @Autowired
    public AccountService accountService;

    @RequestMapping("accountLogin")
    @ResponseBody
    public Boolean accountLogin(HttpSession session, String accountLog, String password) {
        String telephone = null;
        String email = null;
        String accountName = null;
        Account account = null;
        password = Md5Utils.md5(password);
        session.setAttribute("accountLog",accountLog);
        System.out.println(accountLog);

        Boolean b = true;
        int accountId = 0;
        if (accountService.findTelephone(accountLog)) {
            account = accountService.findAccount(accountLog, null, null, password);
        }
        if (accountService.findEmail(accountLog)) {
            account = accountService.findAccount(null, null, accountLog, password);
        }
        if (accountService.findAccountName(accountLog)) {
            account = accountService.findAccount(null, accountLog, null, password);
        }
        if (account != null) {
            session.setAttribute("account", account);
            accountId = account.getAccountId();
            List<FavouriteItem> favour = accountService.getFavourite(accountId);
            account.setFavourite(favour);
            List<Notification> unread = accountService.getUnreadNotes(accountId);
            int noteNum = unread.size();
            session.setAttribute("noteNum", noteNum);
            int favourNum = favour.size();
            session.setAttribute("favourNum", favourNum);
            session.setAttribute("accountId", accountId);
        } else {
            b = false;
        }
        return b;
    }

    @RequestMapping("accountLogout")
    public String AccountLogout(HttpSession session) {
        session.removeAttribute("account");
        return "AccountLogin";
    }

    @RequestMapping("viewFavourite")
    public String getFavourite(Model model, HttpSession session) {
        int accountId = (Integer) session.getAttribute("accountId");
        int favourNum = 0;
        List<FavouriteItem> favours = new ArrayList<FavouriteItem>();
        if (accountService.getFavourite(accountId) != null) {
            favours = accountService.getFavourite(accountId);
            favourNum = favours.size();
        } else {
            favours = null;
        }
        session.setAttribute("favourNum", favourNum);
        model.addAttribute("myFavour", favours);
        return "MyFavourite";
    }

    @RequestMapping("validateName")
    @ResponseBody
    public Boolean validateExistName(String accountName) {
        return accountService.findExistAccountName(accountName);
    }

    @RequestMapping("deleteFavour")
    public String deleteFavour(Integer favourId, HttpSession session, RedirectAttributes attr) {
        int accountId = (Integer) session.getAttribute("accountId");
        accountService.deleteFavourite(favourId);
        attr.addAttribute("accountId", accountId);
        return "redirect:viewFavourite.action";
    }

    @RequestMapping("myPage")
    public String myPage(HttpSession session, Model model) {
        int accountId = (Integer) session.getAttribute("accountId");
        int payingNum = accountService.getPayingNum(accountId);
        int shippingNum = accountService.getShippingNum(accountId);
        int uncommentedNum = accountService.getUncommentedNum(accountId);
        model.addAttribute("payingNum", payingNum);
        model.addAttribute("shippingNum", shippingNum);
        model.addAttribute("uncommentedNum", uncommentedNum);
        return "MyPage";
    }

    @RequestMapping("detail")
    public String detail(Integer productId) {
        return "";
    }


    @RequestMapping("payingOrder")
    public String selectPayingOrder(Model model, HttpSession session) {
        int accountId = (Integer) session.getAttribute("accountId");
        List<Order> orders = accountService.getOrderByStatus(accountId, 1);
        for (Order order : orders) {
            order.countMoney();
        }
        model.addAttribute("payingOrder", orders);
        return "PayingOrder";
    }

    @RequestMapping("shippingOrder")
    public String selectShippingOrder(Model model, HttpSession session) {
        int accountId = (Integer) session.getAttribute("accountId");
        List<Order> orders = accountService.getOrderByStatus(accountId, 2);
        for (Order order : orders) {
            order.countMoney();
        }
        model.addAttribute("shippingOrder", orders);
        return "ShippingOrder";
    }

    @RequestMapping("finishedOrder")
    public String selectFinishedOrder(Model model, HttpSession session) {
        int accountId = (Integer) session.getAttribute("accountId");
        List<Order> orders = accountService.getOrderByStatus(accountId, 5);
        for (Order order : orders) {
            order.countMoney();
        }
        model.addAttribute("finishedOrder", orders);
        return "FinishedOrder";
    }

    @RequestMapping("allOrder")
    public String selectAllOrder(Model model, HttpSession session) {
        int accountId = (Integer) session.getAttribute("accountId");
        List<Order> orders = accountService.getAllOrders(accountId);
        for (Order order : orders) {
            order.countMoney();
        }
        model.addAttribute("allOrders", orders);
        return "MyOrder";
    }

    @RequestMapping("groupOrder")
    public String selectAllGroupOrder(Model model, HttpSession session) {
        int accountId = (Integer) session.getAttribute("accountId");
        List<Order> groups = accountService.getAllGroupOrders(accountId);
        for (Order group : groups) {
            group.countMoney();
        }
        model.addAttribute("groupOrder", groups);
        return "GroupOrder";
    }

    @RequestMapping("groupReady")
    public String selectGroupReady(Model model, HttpSession session) {
        int accountId = (Integer) session.getAttribute("accountId");
        List<Order> orders = accountService.getGroupOrderByStatus(accountId, 2);
        for (Order order : orders) {
            order.countMoney();
        }
        model.addAttribute("groupReady", orders);
        return "GroupReady";
    }

    @RequestMapping("groupOver")
    public String selectGroupOver(Model model, HttpSession session) {
        int accountId = (Integer) session.getAttribute("accountId");
        List<Order> orders = accountService.getGroupOrderByStatus(accountId, 5);
        for (Order order : orders) {
            order.countMoney();
        }
        model.addAttribute("groupOver", orders);
        return "GroupOver";
    }

    @RequestMapping("groupRunning")
    public String selectGroupRunning(Model model, HttpSession session) {
        int accountId = (Integer) session.getAttribute("accountId");
        List<Order> orders = accountService.getGroupOrderByStatus(accountId, 6);
        for (Order order : orders) {
            order.countMoney();
        }
        model.addAttribute("groupRunning", orders);
        return "GroupRunning";
    }

    @RequestMapping("statusGroupOrder")
    public String selectGroupOrderByStatus(HttpSession session, Integer status, Model model) {
        int accountId = (Integer) session.getAttribute("accountId");
        List<Order> groupOrders = accountService.getGroupOrderByStatus(accountId, status);
        model.addAttribute("statusGroupOrders", groupOrders);
        return "GroupOrder";
    }

    @RequestMapping("personalInfo")
    public String viewPersonalInfo() {
        return "PersonalInfo";
    }

    @RequestMapping("accountInfo")
    public String viewAccountInfo() {
        return "AccountInfo";
    }

    @RequestMapping("addConfidentiality")
    public String insertConfidentiality(Confiditiality confiditiality, HttpSession session) {
        Account account = (Account)session.getAttribute("account");
        account.setConfiditiality(confiditiality);
        session.setAttribute("account",account);
        confiditiality.setAccount(account);
        System.out.println(confiditiality.getFamilyAnswer());
        System.out.println(confiditiality.getAccount().getRealName());
        accountService.insertConfidentiality(confiditiality);
        return "forward:accountInfo.action";
    }

    @RequestMapping("validate")
    @ResponseBody
    public Boolean validatePassword(String password, HttpSession session) {
        int accountId = (Integer) session.getAttribute("accountId");
        password = Md5Utils.md5(password);
        boolean b = accountService.findPassword(password, accountId);
        return b;
    }

    @RequestMapping("registTelephone")
    public String registTelephone(String telephone, HttpSession session, Model model) {
        int accountId = accountService.insertTelephone(telephone);
        Account account = accountService.getAccountById(accountId);
        session.setAttribute("account",account);
        session.setAttribute("accountId", accountId);
        return "registEmail";
    }

    @RequestMapping("registAccount")
    public String registAccount(Account account) {
        String password = account.getPassword();
        if(5<password.length()&&password.length()<9){
            account.setSecurityLevel(0);
        }
        if(8<password.length()&&password.length()<13){
            account.setSecurityLevel(1);
        }
        if(12<password.length()){
            account.setSecurityLevel(2);
        }
        password = Md5Utils.md5(password);
        account.setPassword(password);
        accountService.updateNamePass(account);
        return "regist3";
    }

    @RequestMapping("registInfo")
    public String registInfo(Account account) {
        accountService.updatePerson(account);
        return "registA";
    }

    @RequestMapping("registAvatar")
    @ResponseBody
    public String registAvatar(String avatarUrl, HttpSession session) {
        Account account = new Account();
        account.setAvatarUrl(avatarUrl);
        int accountId = (Integer) session.getAttribute("accountId");
        account.setAccountId(accountId);
        accountService.updateAvatar(account);
        return "regist4.jsp";
    }

    @RequestMapping("registFinish")
    public String registFinish(HttpSession session) {
        int accountId = (Integer) session.getAttribute("accountId");
        accountService.addFirstNotification(accountId);
        session.removeAttribute("accountId");
        session.removeAttribute("account");
        return "AccountLogin";
    }


    @RequestMapping("updateAvatar")
    @ResponseBody
    public String updateAvatar(HttpSession session, String avatarUrl) {
        Account account = (Account) session.getAttribute("account");
        account.setAvatarUrl(avatarUrl);
        session.setAttribute("account", account);
        accountService.updateAlAvatar(account);
        return "PersonalInfo.jsp";
    }


    @RequestMapping("updatePassword")
    public String updatePassword(String newPassword, HttpSession session,Integer path) {
        Account account = (Account) session.getAttribute("account");
        String url = "forward:accountInfo.action";
        if(5<newPassword.length()&&newPassword.length()<9){
            account.setSecurityLevel(0);
        }
        if(8<newPassword.length()&&newPassword.length()<13){
            account.setSecurityLevel(1);
        }
        if(12<newPassword.length()){
            account.setSecurityLevel(2);
        }
        newPassword = Md5Utils.md5(newPassword);
        account.setPassword(newPassword);
        session.setAttribute("account", account);
        accountService.updatePassword(account);
        if(path==1){
            url="AccountLogin";
        }
        System.out.println(path);
        return url;
    }


    @RequestMapping("updateEmail")
    public String updateEmail(String email, HttpSession session,Integer path) {
        Account account = (Account) session.getAttribute("account");
        String url = "AccountInfo.jsp";
        accountService.updateEmail(account.getAccountId(), email);
        account.setEmail(email);
        session.setAttribute("account", account);
        if(path==1){
            url="regist2";
        }
        return url;
    }

    @RequestMapping("changePassword")
    public String changePassword(HttpSession session, Model model) {
        int accountId = (Integer) session.getAttribute("accountId");
        model.addAttribute("accountId", accountId);
        return "Password";
    }

    //通过关键字搜索订单
    @RequestMapping("selectOrderByKey")
    public String selectOrderByKey(HttpSession session, String key, Model model, Integer status) {
        System.out.println(status);
        String url = "";
        int orderStatus = 0;
        if (status == null) {
            url = "MyOrder";
        }
        else if (status == 1) {
            url = "PayingOrder";
            orderStatus = status;
        }
        else if (status == 2) {
            url = "ShippingOrder";
            orderStatus = status;
        }
        else if (status == 5) {
            url = "FinishedOrder";
            orderStatus = status;
        }
//        else {
//            orderStatus = status;
//            if (status == 1) {
//                url = "PayingOrder";
//            }
//            if (status == 2) {
//                url = "ShippingOrder";
//            }
//            if (status == 4) {
//                url = "FinishedOrder";
//            }
//        }
        int accountId = (Integer) session.getAttribute("accountId");
        String orderId = null;
        String productId = null;
        String productName = null;
        List<Order> orders = new ArrayList<Order>();
        if (key.length() == 9) {
            productId = key;
            orders = accountService.selectOrdersByKey(accountId, productId, null, null, orderStatus);
        }
        if (key.length() == 16) {
            orderId = key;
            orders = accountService.selectOrdersByKey(accountId, null, null, orderId, orderStatus);
        } else {
            int n = 0;
            for (int i = 0; i < key.length(); i++) {
                n = (int) key.charAt(i);
                if (19968 <= n && n < 40869) {
                    productName = key;
                    orders = accountService.selectOrdersByKey(accountId, null, productName, null, orderStatus);
                }
            }
        }
        for (Order order : orders) {
            order.countMoney();
        }
        model.addAttribute("allOrders", orders);
        return url;
    }

    @RequestMapping("updatePersonalInfo")
    public String updatePersonalInfo(Account ac, HttpSession session) {
        System.out.println("11111111111111111111111111111111111111111");
        Account account = (Account) session.getAttribute("account");
        account.setRealName(ac.getRealName());
        account.setBirthday(ac.getBirthday());
        account.setGender(ac.getGender());
        session.setAttribute("account", account);
        ac.setAccountId(account.getAccountId());
        accountService.updateAccountInfo(ac);
        System.out.println(account.getRealName());
        return "PersonalInfo.jsp";
    }

    //工具方法，用于取得当前用户
    //ZHY加的。
    @RequestMapping("getCurrentAccount")
    @ResponseBody
    public Account getCurrentAccount(HttpSession session) {
        return (Account) session.getAttribute("account");
    }

    //用于登录后跳转到用户主页。
    //ZHY加的。
    @RequestMapping("loginSuccessRedirect")
    public String loginSuccessRedirect() {
//        return "redirect:myPage.action"; 合并的时候用这个。。
//        return "redirect:navbarTop.html";
        return "index";
    }


    @RequestMapping("imgcode")
    public void getimgcode(HttpServletRequest request,
                           HttpServletResponse response) throws IOException {

        HttpSession session = request.getSession();
        session.removeAttribute("code2");
        response.setContentType("image/jpeg");
        ServletOutputStream sos = response.getOutputStream();

        response.setHeader("Pragma", "No-cache");
        response.setHeader("Cache-Control", "no-cache");
        response.setDateHeader("Expires", 0);

        BufferedImage image = new BufferedImage(130, 38,
                BufferedImage.TYPE_INT_RGB);
        Graphics g = image.getGraphics();
        char[] rands = generateCheckCode();
        drawBackground(g);
        drawRands(g, rands);
        g.dispose();

        ByteArrayOutputStream bos = new ByteArrayOutputStream();
        ImageIO.write(image, "JPEG", bos);
        byte[] buf = bos.toByteArray();
        response.setContentLength(buf.length);
        sos.write(buf);
        bos.close();
        sos.close();
        session.setAttribute("code", new String(rands));
    }


    @RequestMapping("forgetPass")
    @ResponseBody
    public String forgetPass(String accountLog, HttpSession session){
        String url="sendEmail.jsp";
        if(accountLog==null){
            accountLog=(String)session.getAttribute("accountLog");
            url="sendEmail";
        }
        System.out.println(accountLog);
        Account a = new Account();
        if (accountService.findTelephone(accountLog)) {
            a.setTelephone(accountLog);
        }
        if (accountService.findEmail(accountLog)) {
            a.setEmail(accountLog);
        }
        if (accountService.findAccountName(accountLog)) {
            a.setAccountName(accountLog);
        }
        Account account  = accountService.getAccountByName(a);
        System.out.println(account.getEmail());
        session.setAttribute("Eaccount",account);
        session.setAttribute("account",account);
        return url;
    }


    //验证验证码是否正确
    @RequestMapping("checkcode")
    @ResponseBody
    public Boolean logcode(HttpServletRequest request, String checkcode) {
        String code = (String) request.getSession().getAttribute("code");
        if (!code.equalsIgnoreCase(checkcode.toLowerCase())) {
            return false;
        }else{
            return true;
        }
    }

    //发送油箱验证码
    @RequestMapping("sendEmail")
    public void sendEmail(String toMail,HttpSession session){
        System.out.println(toMail);
        String code = CusMethod.getSixCode();
        System.out.println(code);
        session.setAttribute("emailcode",code);
        Email.getEmailMesg(toMail,code);
    }

    @RequestMapping("validateECode")
    @ResponseBody
    public Boolean validateECode(HttpSession session,String ecode){
        System.out.println("kkkkkkkkkkkkk");
        System.out.println(ecode);
        String code = (String)session.getAttribute("emailcode");
        return ecode.equals(code);
    }

    @RequestMapping("resetAccount")
    public String resetAccount(){
        return "ChangePass";
    }
    @RequestMapping("addToFavorite")
    public  @ResponseBody String addToFavorite(String productId, String accountId) {
        Product product = new Product();
        product.setProductId(Integer.parseInt(productId));
        FavouriteItem favouriteItem = new FavouriteItem();
        favouriteItem.setProduct(product);
        Integer favoriteId =  accountService.addToFavorite(favouriteItem, accountId);
        return favoriteId.toString();
    }

    @RequestMapping("cancelFavorite")
    public @ResponseBody String cancelFavorite(String favoriteId) {
        Integer favourId;
        if(favoriteId!=null&&!favoriteId.equals("")){
            favourId=Integer.parseInt(favoriteId);
        }else{
            favourId=null;
        }
        accountService.cancelFavorite(favourId);
        return "success";
    }
}
