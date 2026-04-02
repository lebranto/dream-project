package com.kh.jipshop.admin.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class AdminOrder {

    private int rowNum;

    private int orderId;
    private int detailId;

    private String ordererName;
    private String memberId;
    private String ordererPhone;
    private int orderTotalPrice;
    private String orderDateStr;

    private String orderCancelYn;
    private String cancelStatus;
    private String cancelStatusLabel;
    private String orderStatusLabel;

    private String deliveryYn;
    private String deliveryStatus;

    private int deliveryId;
    private String expectedDateStr;

    private String recvName;
    private String recvPhone;
    private String recvAddress;

    private String productName;
    private int productPrice;
    private String productPhoto1;

    private String companyName;
    private String companyPhone;
    private String companyAddress;

    private String orderStatus;

    private String ordererEmail;
    private String orderMemo;

    // 개별취소용
    private String cancelYn;
    private String cancelReason;
    private String cancelRequestDateStr;
    
    //판매자 귀책, 배송비부담 
    private String responsibilityType;
    private String shippingFeePolicy;
}