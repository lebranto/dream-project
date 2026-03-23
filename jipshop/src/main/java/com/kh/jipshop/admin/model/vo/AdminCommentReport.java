package com.kh.jipshop.admin.model.vo;

import java.sql.Date;

public class AdminCommentReport {

    private int reportId;
    private int commentId;
    private String reportTypeName;
    private String reportReason;
    private Date reportDate;

    private int boardNo;
    private String commentContent;
    private Date commentRegDate;
    private String commentWriterId;

    public AdminCommentReport() {}

    public int getReportId() {
        return reportId;
    }

    public void setReportId(int reportId) {
        this.reportId = reportId;
    }

    public int getCommentId() {
        return commentId;
    }

    public void setCommentId(int commentId) {
        this.commentId = commentId;
    }

    public String getReportTypeName() {
        return reportTypeName;
    }

    public void setReportTypeName(String reportTypeName) {
        this.reportTypeName = reportTypeName;
    }

    public String getReportReason() {
        return reportReason;
    }

    public void setReportReason(String reportReason) {
        this.reportReason = reportReason;
    }

    public Date getReportDate() {
        return reportDate;
    }

    public void setReportDate(Date reportDate) {
        this.reportDate = reportDate;
    }

    public int getBoardNo() {
        return boardNo;
    }

    public void setBoardNo(int boardNo) {
        this.boardNo = boardNo;
    }

    public String getCommentContent() {
        return commentContent;
    }

    public void setCommentContent(String commentContent) {
        this.commentContent = commentContent;
    }

    public Date getCommentRegDate() {
        return commentRegDate;
    }

    public void setCommentRegDate(Date commentRegDate) {
        this.commentRegDate = commentRegDate;
    }

    public String getCommentWriterId() {
        return commentWriterId;
    }

    public void setCommentWriterId(String commentWriterId) {
        this.commentWriterId = commentWriterId;
    }
}