package com.kh.jipshop.mypage.model.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class OrderDetail {

	private int detailId;
	private int orderId;
	private int productId;
	private int detailQty;
	private int detailprice;
	

}
