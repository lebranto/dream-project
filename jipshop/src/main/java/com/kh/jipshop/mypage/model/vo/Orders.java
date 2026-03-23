package com.kh.jipshop.mypage.model.vo;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Data
public class Orders {
	
	
    // 주문관련
    private int orderId;
    private int memberId;
    private Date orderDate;
    private int orderTotalPrice;
    private int orderDeliveryFee;
    private String ordererName;
    private String odererPhone;
    private String ordererEmail;
    private String orderMemo;
    
    //받는 사람
    private String recvName;
    private String recvAddress;
    private String recvPhone;
    
    // 구매 취소 관련
    private char orderCancleYn;
    private Date cancleRequestDate;
    private String cancleReason;
    private String cancleStatus;
	
	
	

}
