package com.kh.jipshop.admin.model.vo;

import java.sql.Date;

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

    
}