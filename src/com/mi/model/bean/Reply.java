package com.mi.model.bean;

/**
 * @author daiqibin
 * @version 1.0.0
 * @date 2018/7/30
 * @description 评价回复
 */
public class Reply {
    public int replyId;//回复Id
    public Account account;//小米账户
    public String content;//内容
    public int commentId;//评论Id

    public int getCommentId() {
        return commentId;
    }

    public void setCommentId(int commentId) {
        this.commentId = commentId;
    }

    public int getReplyId() {
        return replyId;
    }

    public void setReplyId(int replyId) {
        this.replyId = replyId;
    }

    public Account getAccount() {
        return account;
    }

    public void setAccount(Account account) {
        this.account = account;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
}
