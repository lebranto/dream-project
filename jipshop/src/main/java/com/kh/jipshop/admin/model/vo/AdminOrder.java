package com.kh.jipshop.admin.model.vo;

public class AdminOrder {

    private int rowNum;
    private int orderId;

    private String orderDateStr;

    private String ordererName;
    private String ordererPhone;
    private String ordererEmail;
    private String ordererAddress;

    private String recvName;
    private String recvPhone;
    private String recvAddress;

    private int productId;
    private String productName;
    private int productPrice;
    private String productPhoto1;

    private String companyName;
    private String companyPhone;
    private String companyAddress;

    private String expectedDateStr;
    private String deliveryYn;
    private String deliveryStatus;
    private String dnum;

    private String orderCancelYn;

    private String startAddress;
    private String arriveAddress;

    public AdminOrder() {}

    public int getRowNum() {
        return rowNum;
    }

    public void setRowNum(int rowNum) {
        this.rowNum = rowNum;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public String getOrderDateStr() {
        return orderDateStr;
    }

    public void setOrderDateStr(String orderDateStr) {
        this.orderDateStr = orderDateStr;
    }

    public String getOrdererName() {
        return ordererName;
    }

    public void setOrdererName(String ordererName) {
        this.ordererName = ordererName;
    }

    public String getOrdererPhone() {
        return ordererPhone;
    }

    public void setOrdererPhone(String ordererPhone) {
        this.ordererPhone = ordererPhone;
    }

    public String getOrdererEmail() {
        return ordererEmail;
    }

    public void setOrdererEmail(String ordererEmail) {
        this.ordererEmail = ordererEmail;
    }

    public String getOrdererAddress() {
        return ordererAddress;
    }

    public void setOrdererAddress(String ordererAddress) {
        this.ordererAddress = ordererAddress;
    }

    public String getRecvName() {
        return recvName;
    }

    public void setRecvName(String recvName) {
        this.recvName = recvName;
    }

    public String getRecvPhone() {
        return recvPhone;
    }

    public void setRecvPhone(String recvPhone) {
        this.recvPhone = recvPhone;
    }

    public String getRecvAddress() {
        return recvAddress;
    }

    public void setRecvAddress(String recvAddress) {
        this.recvAddress = recvAddress;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public int getProductPrice() {
        return productPrice;
    }

    public void setProductPrice(int productPrice) {
        this.productPrice = productPrice;
    }

    public String getProductPhoto1() {
        return productPhoto1;
    }

    public void setProductPhoto1(String productPhoto1) {
        this.productPhoto1 = productPhoto1;
    }

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    public String getCompanyPhone() {
        return companyPhone;
    }

    public void setCompanyPhone(String companyPhone) {
        this.companyPhone = companyPhone;
    }

    public String getCompanyAddress() {
        return companyAddress;
    }

    public void setCompanyAddress(String companyAddress) {
        this.companyAddress = companyAddress;
    }

    public String getExpectedDateStr() {
        return expectedDateStr;
    }

    public void setExpectedDateStr(String expectedDateStr) {
        this.expectedDateStr = expectedDateStr;
    }

    public String getDeliveryYn() {
        return deliveryYn;
    }

    public void setDeliveryYn(String deliveryYn) {
        this.deliveryYn = deliveryYn;
    }

    public String getDeliveryStatus() {
        return deliveryStatus;
    }

    public void setDeliveryStatus(String deliveryStatus) {
        this.deliveryStatus = deliveryStatus;
    }

    public String getDnum() {
        return dnum;
    }

    public void setDnum(String dnum) {
        this.dnum = dnum;
    }

    public String getOrderCancelYn() {
        return orderCancelYn;
    }

    public void setOrderCancelYn(String orderCancelYn) {
        this.orderCancelYn = orderCancelYn;
    }

    public String getStartAddress() {
        return startAddress;
    }

    public void setStartAddress(String startAddress) {
        this.startAddress = startAddress;
    }

    public String getArriveAddress() {
        return arriveAddress;
    }

    public void setArriveAddress(String arriveAddress) {
        this.arriveAddress = arriveAddress;
    }

    @Override
    public String toString() {
        return "AdminOrder [rowNum=" + rowNum + ", orderId=" + orderId + ", orderDateStr=" + orderDateStr
                + ", ordererName=" + ordererName + ", ordererPhone=" + ordererPhone + ", ordererEmail="
                + ordererEmail + ", ordererAddress=" + ordererAddress + ", recvName=" + recvName + ", recvPhone="
                + recvPhone + ", recvAddress=" + recvAddress + ", productId=" + productId + ", productName="
                + productName + ", productPrice=" + productPrice + ", productPhoto1=" + productPhoto1
                + ", companyName=" + companyName + ", companyPhone=" + companyPhone + ", companyAddress="
                + companyAddress + ", expectedDateStr=" + expectedDateStr + ", deliveryYn=" + deliveryYn
                + ", deliveryStatus=" + deliveryStatus + ", dnum=" + dnum + ", orderCancelYn=" + orderCancelYn
                + ", startAddress=" + startAddress + ", arriveAddress=" + arriveAddress + "]";
    }
}