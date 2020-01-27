package com.mi.model.utils;


import com.mi.model.bean.SecondClassification;

import java.util.ArrayList;
import java.util.Date;
import java.util.Map;
import java.util.Random;

public class Utils {

    /**
     * get the difference time between the current time and the shelf
     * time of the newest product of the second classification
     * @param secondClassification
     * @return the difference time
     * @author huang jiarui
     * @version 1.0
     */
    public static long getMinDifferenceTime(SecondClassification secondClassification){

        long result = Long.MAX_VALUE;

        long temp = 0;

        Date now = new Date();

        if(secondClassification.getProducts().size() == 0){
            return result;
        }

        for(int i = 0 ; i < secondClassification.getProducts().size() ; i++){
            temp = now.getTime() - secondClassification.getProducts().get(i).getProductTime().getTime();
            if(temp < result){
                result = temp;
            }
        }

        return result;

    }

    /**
     * set the array to zero
     * @param array
     * @author huang jiarui
     * @version 1.0
     */
    public static void setZero(double[] array) {
        for (int i = 0; i < array.length; i++) {
            array[i] = 0;
        }
    }

    public static void setZero(int[] array) {
        for (int i = 0; i < array.length; i++) {
            array[i] = 0;
        }
    }

    /**
     * shuffle the array randomly
     * @param array
     * @author huang jiarui
     * @version 1.0
     */
    public static void shuffle(int[] array) {
        int N = array.length;

        if (N <= 1)
            return;
        for (int i = 0; i < N; i++) {
            int j = i + new Random().nextInt(N-i);
            int swap = array[i];
            array[i] = array[j];
            array[j] = swap;
        }
    }
}
