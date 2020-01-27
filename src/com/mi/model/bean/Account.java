package com.mi.model.bean;

import java.util.List;

public class Account {
    private int accountId;

    public String getAccountName() {
        return accountName;
    }

    public void setAccountName(String accountName) {
        this.accountName = accountName;
    }

    private String accountName;
    private String telephone;
    private String password;
    private String realName;
    private String avatarUrl;
    private String gender;
    private String birthday;

    private List<FavouriteItem> favourite;
    private List<Order> orders;
    private List<Notification> notes;

    public Confiditiality getConfiditiality() {
        return confiditiality;
    }

    public void setConfiditiality(Confiditiality confiditiality) {
        this.confiditiality = confiditiality;
    }

    private Confiditiality confiditiality;

    public String getTelephone() {
        return telephone;
    }

    public void setTelephone(String telephone) {
        this.telephone = telephone;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRealName() {
        return realName;
    }

    public void setRealName(String realName) {
        this.realName = realName;
    }

    public String getAvatarUrl() {
        return avatarUrl;
    }

    public void setAvatarUrl(String avatarUrl) {
        this.avatarUrl = avatarUrl;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getBirthday() {
        return birthday;
    }

    public void setBirthday(String birthday) {
        this.birthday = birthday;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getSecurityLevel() {
        return securityLevel;
    }

    public void setSecurityLevel(int securityLevel) {
        this.securityLevel = securityLevel;
    }

    public List<Receiver> getReceivers() {
        return receivers;
    }

    public void setReceivers(List<Receiver> receivers) {
        this.receivers = receivers;
    }

    public List<Comment> getComments() {
        return comments;
    }

    public void setComments(List<Comment> comments) {
        this.comments = comments;
    }

    public CartItem getCart() {
        return cart;
    }

    public void setCart(CartItem cart) {
        this.cart = cart;
    }

    public List<FavouriteItem> getFavourite() {
        return favourite;
    }

    public void setFavourite(List<FavouriteItem> favourite) {
        this.favourite = favourite;
    }

    public List<Order> getOrders() {
        return orders;
    }

    public void setOrders(List<Order> orders) {
        this.orders = orders;
    }

    public List<Notification> getNotes() {
        return notes;
    }

    public void setNotes(List<Notification> notes) {
        this.notes = notes;
    }

    private String email;
    private int securityLevel;
    private List<Receiver> receivers;
    private List<Comment> comments;
    private CartItem cart;

    public int getAccountId() {
        return accountId;
    }

    public void setAccountId(int accountId) {
        this.accountId = accountId;
    }



}
