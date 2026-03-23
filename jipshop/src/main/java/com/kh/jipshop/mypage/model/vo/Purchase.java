package com.kh.jipshop.mypage.model.vo;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@NoArgsConstructor
@Data
public class Purchase {
	
	
	private int orderId;
	private int memberId;
	private int totalPrice;
	private Date orderDate;
	private String productName;
	private String deliveryStatus;	
	
	
	
	

}
