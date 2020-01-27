package com.mi.model.utils;

/**
 * Data Structure: Sparse Vector whose implementation is modified from M4J
 * @version 1.0
 */
public class SparseVector {
    // capacity
    protected int capacity;

    // data
    protected double[] data;

    // Indices to data
    protected int[] index;

    // number of items
    protected int count;

    // number of zero items
    protected int zeroCount;

    // the first index of zero items
    protected int zeroFirstIndex;

    public SparseVector(int capcity) {
        this.capacity = capcity;
        data = new double[0];

        count = 0;
        index = new int[0];

        zeroFirstIndex = 0;
    }

    public SparseVector(int capacity, int[] index, double[] data, int startIdx, int endIdx) {
        this.capacity = capacity;
        int length = endIdx - startIdx + 1;

        this.index = new int[length];
        this.data = new double[length];
        for (int idx = startIdx, idxData = 0; idx <= endIdx; idx++) {
            if (data[idx] != 0.0) {
                this.data[idxData] = data[idx];
                this.index[idxData] = index[idx];
                idxData++;
                count++;
            }
        }

        zeroCount = 0;
        zeroFirstIndex = count;
    }

    public int[] getIndex() {
        int nonZeroCount = count - zeroCount;
        int[] res = new int[nonZeroCount];
        for (int i = 0, idx = 0; i < count; i++) {
            if (data[i] != 0.0) {
                res[idx++] = index[i];
            }
        }

        return res;
    }

}
