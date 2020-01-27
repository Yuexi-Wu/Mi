package com.mi.model.utils;

import java.util.Comparator;
import java.util.Map;

/**
 * Comparator: To sort map {@code Map<Integer,Long>} by ascending value
 * @version 1.0
 */
public class ValueAscComparator implements Comparator<Map.Entry<Integer,Long>> {

    @Override
    public int compare(Map.Entry<Integer,Long> o1, Map.Entry<Integer,Long> o2) {
        return o1.getValue().compareTo(o2.getValue());
    }
}
