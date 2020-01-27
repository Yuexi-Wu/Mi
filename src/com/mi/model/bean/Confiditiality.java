package com.mi.model.bean;

public class Confiditiality {



    private Account account;
    public Account getAccount() {
        return account;
    }
    public void setAccount(Account account) {
        this.account = account;
    }

    private String familyQuestion;
    private String firstQuestion;
    private String schoolQuestion;
    private String selfQuestion;
    private String familyAnswer;
    private String firstAnswer;

    public String getFamilyQuestion() {
        return familyQuestion;
    }

    public void setFamilyQuestion(String familyQuestion) {
        this.familyQuestion = familyQuestion;
    }

    public String getFirstQuestion() {
        return firstQuestion;
    }

    public void setFirstQuestion(String firstQuestion) {
        this.firstQuestion = firstQuestion;
    }

    public String getSchoolQuestion() {
        return schoolQuestion;
    }

    public void setSchoolQuestion(String schoolQuestion) {
        this.schoolQuestion = schoolQuestion;
    }

    public String getSelfQuestion() {
        return selfQuestion;
    }

    public void setSelfQuestion(String selfQuestion) {
        this.selfQuestion = selfQuestion;
    }

    public String getFamilyAnswer() {
        return familyAnswer;
    }

    public void setFamilyAnswer(String familyAnswer) {
        this.familyAnswer = familyAnswer;
    }

    public String getFirstAnswer() {
        return firstAnswer;
    }

    public void setFirstAnswer(String firstAnswer) {
        this.firstAnswer = firstAnswer;
    }

    public String getSchoolAnswer() {
        return schoolAnswer;
    }

    public void setSchoolAnswer(String schoolAnswer) {
        this.schoolAnswer = schoolAnswer;
    }

    public String getSelfAnswer() {
        return selfAnswer;
    }

    public void setSelfAnswer(String selfAnswer) {
        this.selfAnswer = selfAnswer;
    }

    private String schoolAnswer;
    private String selfAnswer;


    public int getConfidentialityId() {
        return confidentialityId;
    }

    public void setConfidentialityId(int confidentialityId) {
        this.confidentialityId = confidentialityId;
    }

    private int confidentialityId;

}
