package com.mi.model.tools;

import java.util.Calendar;
import java.util.Random;
import java.util.UUID;

/**
 * @author daiqibin
 * @version 1.0.0
 * @date 2018/7/19
 * @description
 */
public class CusMethod {

    public static int randomId(){
        Calendar calendar = Calendar.getInstance();
        int year = calendar.get(Calendar.YEAR);
        int dateYear = year%100;
        int dateMonth = calendar.get(Calendar.MONTH);
        int dateDate = calendar.get(Calendar.DATE);
        String dateString = ""+dateYear%10;
        if(dateMonth<10)
            dateString +='0'+dateMonth;
        else
            dateString += dateMonth;
        if(dateDate<10)
            dateString +='0' +dateDate;
        else
            dateString+=dateDate;
        String rdm = getFourRandom();
        String idString = rdm+dateString;
        return Integer.parseInt(idString);
    }

    public static String randomStringId() {
        return UUID.randomUUID().toString().replace("-", "").toUpperCase().substring(0,16);
    }

    public static String getFourRandom(){
        Random random = new Random();
        String fourRandom = random.nextInt(10000) + "";
        int randLength = fourRandom.length();
        if(randLength<4){
            for(int i=1; i<=4-randLength; i++)
                fourRandom = "0" + fourRandom  ;
        }
        return fourRandom;
    }

    public static String getSixCode(){
        int intFlag = 0;
        for (int i = 0; i <= 200; i++)
        {
            intFlag = (int)(Math.random() * 1000000);
            String flag = String.valueOf(intFlag);
            if (flag.length() == 6 && flag.substring(0, 1).equals("9"))
            {
//                System.out.println(intFlag);
            }
            else
            {
                intFlag = intFlag + 100000;
//                System.out.println(intFlag);
            }
        }
        return String.valueOf(intFlag);
    }
}
