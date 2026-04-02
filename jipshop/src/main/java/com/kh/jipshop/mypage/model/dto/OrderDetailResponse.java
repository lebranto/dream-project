package com.kh.jipshop.mypage.model.dto;




import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class OrderDetailResponse {
	
	
	// 멤버쪽 필드
	private String address;
	
	
	// 주문쪽 필드
	private int orderTotalPrice;
	private Date orderDate;
	private int orderId;
	private String recvAddress;
	
	// 상품쪽 필드
	private String productId;
	private String productName;
	private String photo1;
	private int productPrice;
	
	// 상품 디테일 필드
	private int detailId;
	private int detailPrice;
		
	// 최근 본 상품 쪽 필드
	private int viewId;
	private Date viewedDate;
	
	// 배송 상태
	private String deliveryStatus;
	
	// 업체 필드
	private String companyCode;
	private String companyName;
	private String addressAddress;
	
	
}
