package com.kh.jipshop.review.model.vo;

import java.sql.Date;

public class Review {

    private int reviewId;
    private int detailId;
    private int memberNo;

    private int reviewRating;     // ⭐ DB: REVIEW_RATING
    private String reviewContent; // ⭐ DB: REVIEW_CONTENT
    private String reviewPhoto;   // ⭐ DB: REVIEW_PHOTO
    private Date reviewRegDate;   // ⭐ DB: REVIEW_REG_DATE

    public Review() {}

    public int getReviewId() {
        return reviewId;
    }

    public void setReviewId(int reviewId) {
        this.reviewId = reviewId;
    }

    public int getDetailId() {
        return detailId;
    }

    public void setDetailId(int detailId) {
        this.detailId = detailId;
    }

    public int getMemberNo() {
        return memberNo;
    }

    public void setMemberNo(int memberNo) {
        this.memberNo = memberNo;
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

    @Override
    public String toString() {
        return "Review [reviewId=" + reviewId + ", detailId=" + detailId + ", memberNo=" + memberNo
                + ", reviewRating=" + reviewRating + ", reviewContent=" + reviewContent
                + ", reviewPhoto=" + reviewPhoto + ", reviewRegDate=" + reviewRegDate + "]";
    }
}