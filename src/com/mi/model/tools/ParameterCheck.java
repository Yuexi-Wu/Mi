package com.mi.model.tools;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Created by Alexander on 2018/7/19 下午3:10
 */
public class ParameterCheck {

    //验证手机号是否满足正则表达
    public static boolean isTelephoneLegal(String string){
        String regExp = "^((13[0-9])|(15[^4])|(18[0,2,3,5-9])|(17[0-8])|(147))\\d{8}$";
        Pattern pattern = Pattern.compile(regExp);
        Matcher m = pattern.matcher(string);
        return m.matches();
    }

    //验证邮箱是否满足正则表达
    public static boolean isEmailLegal(String string){
        String regExp = "^[a-zA-Z0-9_.-]+@[a-zA-Z0-9-]+(\\.[a-zA-Z0-9-]+)*\\.[a-zA-Z0-9]{2,6}$";
        Pattern pattern = Pattern.compile(regExp);
        Matcher m = pattern.matcher(string);
        return m.matches();
    }
}
