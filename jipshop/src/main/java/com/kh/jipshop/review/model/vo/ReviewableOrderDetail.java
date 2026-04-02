package com.kh.jipshop.review.model.vo;

public class ReviewableOrderDetail {

    private int detailId;
    private int orderId;
    private int productId;
    private int memberNo;

    private String productName;
    private String productPhoto1;
    private int productPrice;
    private String companyName;
    private String petType;
    private String ageGroup;
    private String categoryName;

    public ReviewableOrderDetail() {
    }

    public int getDetailId() {
        return detailId;
    }

    public void setDetailId(int detailId) {
        this.detailId = detailId;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public int getMemberNo() {
        return memberNo;
    }

    public void setMemberNo(int memberNo) {
        this.memberNo = memberNo;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public String getProductPhoto1() {
        return productPhoto1;
    }

    public void setProductPhoto1(String productPhoto1) {
        this.productPhoto1 = productPhoto1;
    }

    public int getProductPrice() {
        return productPrice;
    }

    public void setProductPrice(int productPrice) {
        this.productPrice = productPrice;
    }

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    public String getPetType() {
        return petType;
    }

    public void setPetType(String petType) {
        this.petType = petType;
    }

    public String getAgeGroup() {
        return ageGroup;
    }

    public void setAgeGroup(String ageGroup) {
        this.ageGroup = ageGroup;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    @Override
    public String toString() {
        return "ReviewableOrderDetail [detailId=" + detailId + ", orderId=" + orderId + ", productId=" + productId
                + ", memberNo=" + memberNo + ", productName=" + productName + ", productPhoto1=" + productPhoto1
                + ", productPrice=" + productPrice + ", companyName=" + companyName + ", petType=" + petType
                + ", ageGroup=" + ageGroup + ", categoryName=" + categoryName + "]";
    }
}