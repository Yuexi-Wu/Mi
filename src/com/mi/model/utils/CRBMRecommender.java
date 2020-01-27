package com.mi.model.utils;

import com.mi.model.bean.Scoring;

import java.util.*;
import java.util.Random;
/**
 * This class implementing user-oriented read-values Restricted Boltzmann Machines for
 * Collaborative Filtering
 *
 * The origin paper:
 *
 * Georgiev K, Nakov P. A non-iid framework for collaborative
 * filtering with restricted boltzmann machines[C]
 * //International Conference on Machine Learning.
 * http://proceedings.mlr.press/v28/georgiev13.pdf
 *
 * @author huang jiarui
 * @version 1.1
 */
public class CRBMRecommender {
    public int featureNumber; // 隐含层
    int maxIter; // 训练模型循环次数
    int tSteps; // CD学习步长
    double epsilonw; // 权值学习效率
    double epsilonvb; // 可见层偏置学习效率
    double epsilonhb; // 隐含层偏置学习效率
    double momentum; // 冲量，梯度下降法的一个参数
    double lamtaw; // 权重衰减
    double lamtab; // 偏移值衰减
    public double[][] weights; // 权重
    public double[] visbiases; // 可见层偏置
    public double[] hidbiases; // 隐含层偏置

    double[][] cDpos; // 重构前<vh>的值
    double[][] cDneg; // 重构后<vh>的值
    double[][] cDinc; // 更新值

    double[] poshidact; // 重构前<h>的值
    double[] neghidact; // 重构后<h>的值
    char[] poshidstates; // 可见层到隐藏层的随机阈值激活方法结果，即隐藏层是否激活
    char[] neghidstates; // 隐藏层到可见层的随机阈值激活方法结果，即隐藏层是否激活
    double[] hidbiasinc; // 隐藏层偏置更新值

    char[] curposhidstates; // 当前隐藏层是否激活的值

    double[] posvisact; // 重构前<v>的值
    double[] negvisact; // 重构后<v>的值
    double[] visbiasinc; // 可见层偏置更新值
    double[] negvisprobs; // 已知隐藏层数据，可见层数据的激活概率

    double[] negvissoftmax;// 储存评分值
    int[] productcount; // 某商品的评分总次数
    String predictionType; // 储存预测方式
    public List<Integer> productIds; //商品id与矩阵下标的对应列表
    List<Integer> accountIds; //用户id与矩阵下标的对应列表
    public int numItems; //商品种类数
    int numUsers; //用户个数
    SparseMatrix trainMatrix; //训练矩阵，为稀疏矩阵

    /**
     * set up CRBMRecommender for training
     * @param productIdsIn ids of all products
     * @param accountIdsIn ids of all accounts
     * @param scorings all scorings
     * @author huang jiarui
     * @version 1.0
     */
    public void setup(List<Integer> productIdsIn,List<Integer> accountIdsIn,List<Scoring> scorings)  {
        this.maxIter = 10;
        featureNumber =  500;
        epsilonw = 0.001;
        epsilonvb = 0.001;
        epsilonhb = 0.001;
        tSteps = 1;
        momentum = 0.0d;
        lamtaw = 0.001;
        lamtab = 0.0d;
        predictionType = "mean";
        productIds = productIdsIn;
        accountIds = accountIdsIn;
        numItems = productIds.size();
        numUsers = accountIds.size();

        trainMatrix = new SparseMatrix(productIds,accountIds,scorings);

        weights = new double[numItems][featureNumber];
        visbiases = new double[numItems];
        hidbiases = new double[featureNumber];

        cDpos = new double[numItems][featureNumber];
        cDneg = new double[numItems][featureNumber];
        cDinc = new double[numItems][featureNumber];

        poshidact = new double[featureNumber];
        neghidact = new double[featureNumber];
        poshidstates = new char[featureNumber];
        neghidstates = new char[featureNumber];
        hidbiasinc = new double[featureNumber];

        curposhidstates = new char[featureNumber];

        posvisact = new double[numItems];
        negvisact = new double[numItems];
        visbiasinc = new double[numItems];
        negvisprobs = new double[numItems];

        negvissoftmax = new double[numItems];
        productcount = new int[numItems];

        productcount = new int[numItems];
        for (int u = 0; u < numUsers; u++) {
            int num = trainMatrix.rowSize(u);
            for (int j = 0; j < num; j++) {
                int m = trainMatrix.row(u).getIndex()[j];
                int r = (int) trainMatrix.get(u, m);
                productcount[m]++;
            }
        }
        for (int i = 0; i < numItems; i++) {
            for (int j = 0; j < featureNumber; j++) {
                weights[i][j] = 0.01 * new Random().nextGaussian();
            }
        }
        Utils.setZero(hidbiases);

        for (int i = 0; i < numItems; i++) {
            int mtot = 0;
            mtot = productcount[i];
            if (mtot == 0) {
                visbiases[i] = new Random().nextDouble() * 0.001;
            } else {
                visbiases[i] = Math.log(((double) productcount[i]) / ((double) mtot));
                // visbiases[i][k] = Math.log(((moviecount[i][k]) + 1) /
                // (trainMatrix.columnSize(i)+ softmax));
            }
        }
    }

    /**
     * set up CRBMRecommender for predicting
     * @param productIdsIn ids of all products
     * @param accountIdsIn ids of all accounts
     * @param scorings all scorings
     * @param weightsIn weights to save
     * @param hidbiasesIn hidbiases to save
     * @param visbiasesIn visbiases to save
     * @author huang jiarui
     * @version 1.0
     */
    public void setup(List<Integer> productIdsIn,List<Integer>accountIdsIn,List<Scoring> scorings,double[][] weightsIn,double[] hidbiasesIn,double[] visbiasesIn)  {
        this.maxIter = 10;
        featureNumber =  500;
        epsilonw = 0.001;
        epsilonvb = 0.001;
        epsilonhb = 0.001;
        tSteps = 1;
        momentum = 0.0d;
        lamtaw = 0.001;
        lamtab = 0.0d;
        predictionType = "mean";
        productIds = productIdsIn;
        accountIds = accountIdsIn;
        numItems = productIds.size();
        numUsers = accountIds.size();

        trainMatrix = new SparseMatrix(productIds,accountIds,scorings);

        weights = weightsIn;
        hidbiases = hidbiasesIn;
        visbiases = visbiasesIn;

    }

    /**
     * train model
     * @author huang jiarui
     * @version 1.0
     */
    public void trainModel() {
        int loopcount = 0;
        Random randn = new Random();
        while (loopcount < maxIter) {
            loopcount++;
            Zero();
            int[] visitingSeq = new int[numUsers];
            for (int i = 0; i < visitingSeq.length; i++) {
                visitingSeq[i] = i;
            }
            Utils.shuffle(visitingSeq);
            for (int p = 0; p < visitingSeq.length; p++) {
                int u = visitingSeq[p];
                int num = trainMatrix.rowSize(u);
                double[] sumW = new double[featureNumber];
                negvisprobs = new double[numItems];
                for (int i = 0; i < num; i++) {
                    int m = trainMatrix.row(u).getIndex()[i];
                    int r = (int) trainMatrix.get(u, m);
                    productcount[m]++;
                    if(r==0){
                        posvisact[m] = 0;
                    } else{
                        posvisact[m] = r;
                        for (int h = 0; h < featureNumber; h++) {
                            posvisact[m] -= hidbiases[h];
                        }
                    }

                    for (int h = 0; h < featureNumber; h++) {
                        sumW[h] += r * weights[m][h];
                    }
                }
                for (int h = 0; h < featureNumber; h++) {
                    double probs = 1.0 / (1.0 + Math.exp(-sumW[h] - hidbiases[h]));
                    if (probs > randn.nextDouble()) {
                        poshidstates[h] = 1;
                        poshidact[h] = probs;
                    } else {
                        poshidstates[h] = 0;
                    }
                }
                for (int h = 0; h < featureNumber; h++) {
                    curposhidstates[h] = poshidstates[h];
                }
                int stepT = 0;
                do {
                    boolean finalTStep = (stepT + 1 >= tSteps);

                    for (int i = 0; i < num; i++) {
                        int m = trainMatrix.row(u).getIndex()[i];

                        for (int h = 0; h < featureNumber; h++) {
                            if (curposhidstates[h] == 1) {
                                negvisprobs[m] += weights[m][h];
                            }
                        }
                        negvisprobs[m] = negvisprobs[m] + visbiases[m];

                        if (finalTStep){
                            negvisact[m] = negvisprobs[m] ;
                            for (int h = 0; h < featureNumber; h++) {
                                negvisact[m] -= hidbiases[h];
                            }
                        }
                    }

                    Utils.setZero(sumW);
                    for (int i = 0; i < num; i++) {
                        int m = trainMatrix.row(u).getIndex()[i];

                        for (int h = 0; h < featureNumber; h++) {
                            sumW[h] += negvisprobs[m] * weights[m][h];
                        }
                    }

                    for (int h = 0; h < featureNumber; h++) {
                        double probs = 1.0 / (1.0 + Math.exp(-sumW[h] - hidbiases[h]));

                        if (probs > randn.nextDouble()) {
                            neghidstates[h] = 1;
                            if (finalTStep)
                                neghidact[h] = probs;
                        } else {
                            neghidstates[h] = 0;
                        }
                    }

                    if (!finalTStep) {
                        for (int h = 0; h < featureNumber; h++)
                            curposhidstates[h] = neghidstates[h];
                        Utils.setZero(negvisprobs);
                    }

                } while (++stepT < tSteps);

                for (int i = 0; i < num; i++) {
                    int m = trainMatrix.row(u).getIndex()[i];
                    int r = (int) trainMatrix.get(u, m);

                    for (int h = 0; h < featureNumber; h++) {
                        if (poshidstates[h] == 1) {
                            cDpos[m][h] = r;
                        }
                        cDneg[m][h] = (negvisact[m] + visbiases[m]) * curposhidstates[h];
                    }
                }
                update(u);
            }
        }
    }

    /**
     * update some parameters
     * @param user id of user
     * @author huang jiarui
     * @version 1.0
     */
    private void update(int user) {

        int bSize = 50;
        if (((user + 1) % bSize) == 0 || (user + 1) == numUsers) {
            int numcases = user % bSize;
            numcases++;
            for (int m = 0; m < numItems; m++) {

                if (productcount[m] == 0)
                    continue;
                for (int h = 0; h < featureNumber; h++) {
                    double CDp = cDpos[m][h];
                    double CDn = cDneg[m][h];
                    if (CDp != 0.0 || CDn != 0.0 ) {
                        CDp /= ((double) productcount[m]);
                        CDn /= ((double) productcount[m]);
                        cDinc[m][h] = momentum * cDinc[m][h] + epsilonw * ((CDp - CDn) - lamtaw * weights[m][h]);
                        weights[m][h] += cDinc[m][h];
                    }
                }
                if (posvisact[m] != 0.0 || negvisact[m] != 0.0) {
                    posvisact[m] /= ((double) productcount[m]);
                    negvisact[m] /= ((double) productcount[m]);
                    visbiasinc[m] = momentum * visbiasinc[m]
                            + epsilonvb * (posvisact[m] - negvisact[m] - lamtab * visbiases[m]);
                    visbiases[m] += visbiasinc[m];
                }
            }
            for (int h = 0; h < featureNumber; h++) {
                if (poshidact[h] != 0.0 || neghidact[h] != 0.0) {
                    poshidact[h] /= ((double) (numcases));
                    neghidact[h] /= ((double) (numcases));
                    hidbiasinc[h] = momentum * hidbiasinc[h]
                            + epsilonhb * (poshidact[h] - neghidact[h] - lamtab * hidbiases[h]);
                    hidbiases[h] += hidbiasinc[h];
                }
            }
            Zero();
        }
    }

    /**
     * set portion parameters to zero
     * @author huang jiarui
     * @version 1.0
     */
    private void Zero() {
        cDpos = new double[numItems][featureNumber];
        cDneg = new double[numItems][featureNumber];
        poshidact = new double[featureNumber];
        neghidact = new double[featureNumber];
        posvisact = new double[numItems];
        negvisact = new double[numItems];
        productcount = new int[numItems];
    }

    /**
     * get result of predict
     * @param u id of recommending target account
     * @return list of recommended products' id
     * @author huang jiarui
     * @version 1.0
     */
    public double[] predict(int u){
        double[] negvisprobs = new double[numItems];
        double[] poshidprobs = new double[featureNumber];
        double[] sumWV = new double[numItems];
        double[] sumWP = new double[featureNumber];
        for (int i = 0; i < numItems; i++) {
            double rate = trainMatrix.get(u, i);
            for (int h = 0; h < featureNumber; h++) {
                sumWP[h] += weights[i][h] * rate;

            }
        }
        for (int i = 0; i < numItems; i++) {
            for (int h = 0; h < featureNumber; h++) {
                poshidprobs[h] = 1.0 / (1.0 + Math.exp(0 - sumWP[h] - hidbiases[h]));
            }

            for (int h = 0; h < featureNumber; h++) {
                sumWV[i] += poshidprobs[h] * weights[i][h];
            }

            negvisprobs[i] = visbiases[i] + sumWV[i];
        }
        return negvisprobs;
    }

    /**
     * get result of predict while not logged in
     * @return list of recommended products' id
     * @author huang jiarui
     * @version 1.0
     */
    public double[] predict(){
        double[] negvisprobs = new double[numItems];
        double[] poshidprobs = new double[featureNumber];
        double[] sumWV = new double[numItems];
        double[] sumWP = new double[featureNumber];
        for (int i = 0; i < numItems; i++) {
            double rate = 0 ;

            for (int h = 0; h < featureNumber; h++) {
                sumWP[h] += weights[i][h] * rate;

            }
        }
        for (int i = 0; i < numItems; i++) {
            for (int h = 0; h < featureNumber; h++) {
                poshidprobs[h] = 1.0 / (1.0 + Math.exp(0 - sumWP[h] - hidbiases[h]));
            }

            for (int h = 0; h < featureNumber; h++) {
                sumWV[i] += poshidprobs[h] * weights[i][h];
            }

            negvisprobs[i] = visbiases[i] + sumWV[i];
        }
        return negvisprobs;
    }
}