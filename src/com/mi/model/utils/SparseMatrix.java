package com.mi.model.utils;

import com.mi.model.bean.Scoring;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

/**
 * Data Structure: Sparse Matrix whose implementation is modified from M4J library and librec.
 * @author huang jiarui
 * @version 1.0
 */
public class SparseMatrix {
    // matrix dimension
    public int numRows, numColumns;

    // Compressed Row Storage (CRS)
    public double[] rowData;
    public int[] rowPtr, colInd;

    public SparseMatrix(List<Integer> productIds, List<Integer> accountIds, List<Scoring> scorings){
        numRows = accountIds.size();
        numColumns = productIds.size();
        double[][] tempData = new double[numRows][numColumns];
        for(int i = 0 ; i < numRows ; i++){
            for(int j = 0 ; j < numColumns ; j++){
                tempData[i][j] = 0;
            }
        }
        for(Scoring s : scorings){
            int tempRow = 0;
            int tempColumn = 0;
            for(int i = 0 ; i < numRows ; i++){
                if(accountIds.get(i) == s.getAccountId()){
                    tempRow = i;
                    break;
                }
            }
            for(int j = 0 ; j < numColumns ; j++){
                if(productIds.get(j) == s.getProductId()){
                    tempColumn = j;
                    break;
                }
            }
            tempData[tempRow][tempColumn] = s.getScore();
        }
        rowData = new double[scorings.size()];
        colInd = new int[scorings.size()];
        rowPtr = new int[numRows + 1];
        int count = 0;
        for(int i = 0 ; i < numRows ; i++){
            int tempNumber = 0;
            for(int j = 0 ; j < numColumns ; j++){
                if(tempData[i][j]!=0){
                    tempNumber ++;
                    rowData[count] = tempData[i][j];
                    colInd[count] = j;
                    count ++;
                }
            }
            rowPtr[i + 1] = rowPtr[i] + tempNumber;
        }
    }

    public int rowSize(int row) {

        int size = 0;
        for (int j = rowPtr[row]; j < rowPtr[row + 1]; j++) {
            if (rowData[j] != 0.0)
                size++;
        }
        return size;
    }

    public SparseVector row(int row) {

        SparseVector sv;

        if (row < numRows) {
            sv = new SparseVector(numColumns, colInd, rowData, rowPtr[row], rowPtr[row + 1] - 1);
        } else {
            sv = new SparseVector(numColumns);
        }
        // return an empty vector if the row does not exist in training matrix
        return sv;
    }

    public double get(int row, int column) {

        int index = Arrays.binarySearch(colInd, rowPtr[row], rowPtr[row + 1], column);

        if (index >= 0)
            return rowData[index];
        else
            return 0;
    }

}
