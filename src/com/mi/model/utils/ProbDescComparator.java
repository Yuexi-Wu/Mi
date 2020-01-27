package com.mi.model.utils;

import java.util.Comparator;
import java.util.Map;

/**
 * Comparator: To sort map {@code Map<Integer,Double>} by descending value
 * @version 1.0
 */
public class ProbDescComparator implements Comparator<Map.Entry<Integer,Double>> {

    @Override
    public int compare(Map.Entry<Integer,Double> o1, Map.Entry<Integer,Double> o2) {
        return o2.getValue().compareTo(o1.getValue());
    }
}
