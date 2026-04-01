package com.kh.jipshop.mypage.model.vo;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class OrderDetail {

	private int detailId;
	private int orderId;
	private int productId;
	private int detailQty;
	private int detailPrice;
	private String cancelYn;
	private String cancelStatus;
	private Date cancelRequestDate;
	private String cancelReason;
	private String cancelRequestDateStr;
	private String detailCancelStatusLabel;

}
