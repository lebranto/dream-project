package com.kh.jipshop.admin.model.vo;

import java.sql.Date;

import lombok.Data;

@Data
public class AdminOrderDetailItem {

    private int detailId;
    private int orderId;
    private int productId;

    private String productName;
    private String productPhoto1;

    private int detailQty;
    private int detailPrice;

    private int itemTotalPrice;

    private String dnum;
    private String deliveryYn;
    private String deliveryStatus;
    private String courier;
    private Date expectedDate;
}