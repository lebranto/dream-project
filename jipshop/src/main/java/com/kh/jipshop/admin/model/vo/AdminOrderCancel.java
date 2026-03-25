package com.kh.jipshop.admin.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class AdminOrderCancel {

	private int rnum;

    private int orderId;
    private int memberNo;

    private Date orderDate;
    private int orderTotalPrice;
    private int orderDeliveryFee;

    private String ordererName;
    private String ordererPhone;
    private String ordererEmail;

    private String recvName;
    private String recvAddress;
    private String recvPhone;
    private String orderMemo;

    private String orderCancelYn;
    private Date cancelRequestDate;
    private String cancelReason;
    private String cancelStatus;

    private int detailId;
    private int productId;
    private int detailQty;
    private int detailPrice;

    private String productName;
}
