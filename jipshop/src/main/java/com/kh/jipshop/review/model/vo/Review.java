package com.kh.jipshop.review.model.vo;

import java.sql.Date;

public class Review {

    private int reviewId;
    private int memberNo;
    private int detailId;
    private int reviewRating;
    private String reviewContent;
    private String reviewPhoto;
    private Date reviewRegDate;
    private String reviewActiveYn;

    public Review() {
    }

    public int getReviewId() {
        return reviewId;
    }

    public void setReviewId(int reviewId) {
        this.reviewId = reviewId;
    }

    public int getMemberNo() {
        return memberNo;
    }

    public void setMemberNo(int memberNo) {
        this.memberNo = memberNo;
    }

    public int getDetailId() {
        return detailId;
    }

    public void setDetailId(int detailId) {
        this.detailId = detailId;
    }

    public int getReviewRating() {
        return reviewRating;
    }

    public void setReviewRating(int reviewRating) {
        this.reviewRating = reviewRating;
    }

    public String getReviewContent() {
        return reviewContent;
    }

    public void setReviewContent(String reviewContent) {
        this.reviewContent = reviewContent;
    }

    public String getReviewPhoto() {
        return reviewPhoto;
    }

    public void setReviewPhoto(String reviewPhoto) {
        this.reviewPhoto = reviewPhoto;
    }

    public Date getReviewRegDate() {
        return reviewRegDate;
    }

    public void setReviewRegDate(Date reviewRegDate) {
        this.reviewRegDate = reviewRegDate;
    }

    public String getReviewActiveYn() {
        return reviewActiveYn;
    }

    public void setReviewActiveYn(String reviewActiveYn) {
        this.reviewActiveYn = reviewActiveYn;
    }

    @Override
    public String toString() {
        return "Review [reviewId=" + reviewId + ", memberNo=" + memberNo + ", detailId=" + detailId
                + ", reviewRating=" + reviewRating + ", reviewContent=" + reviewContent + ", reviewPhoto="
                + reviewPhoto + ", reviewRegDate=" + reviewRegDate + ", reviewActiveYn=" + reviewActiveYn + "]";
    }
}