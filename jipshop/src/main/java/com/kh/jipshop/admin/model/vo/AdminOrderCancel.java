package com.kh.jipshop.admin.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class AdminOrderCancel {

    private int detailId;
    private int orderId;
    private String ordererName;
    private String productName;

    private String cancelReason;
    private String cancelRequestDateStr;

    private String orderCancelYn;
    private String cancelStatus;
    private String cancelStatusLabel;

    private String deliveryStatus;
    private String responsibilityType;
    private String shippingFeePolicy;
}