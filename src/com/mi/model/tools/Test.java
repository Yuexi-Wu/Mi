package com.mi.model.tools;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * Created by Alexander on 2018/7/24 下午7:57
 */
public class Test {
    public static void main(String[] args){
//      for (int i = 0; i < 6; i++){
//            Calendar cal = Calendar.getInstance();
//            cal.add(Calendar.MONTH, -i);
//            cal.set(Calendar.DAY_OF_MONTH, 0);
//            cal.set(Calendar.HOUR_OF_DAY, 23);
//            cal.set(Calendar.MINUTE, 59);
//            cal.set(Calendar.SECOND, 59);
//            System.out.println(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(cal.getTime()));
//            cal.set(Calendar.DAY_OF_MONTH,1);
//            cal.set(Calendar.HOUR_OF_DAY, 0);
//            cal.set(Calendar.MINUTE, 0);
//            cal.set(Calendar.SECOND, 0);
//            System.out.println(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(cal.getTime()));
//          System.out.println((cal.get(Calendar.MONTH) + 1) + "月");
//        }
        System.out.println(Md5Utils.md5("zkn1214"));
    }
}
