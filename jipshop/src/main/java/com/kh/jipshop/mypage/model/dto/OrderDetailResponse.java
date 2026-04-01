package com.kh.jipshop.mypage.model.dto;




import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class OrderDetailResponse {
	
	private int orderTotalPrice;
    private Date orderDate;
    private int orderId;

    private String productName;
    private String photo1;
    private String deliveryStatus;

    private int detailPrice;
    private int detailId;

    private String cancelYn;
    private String cancelStatus;
    private String cancelRequestDateStr;
    private String cancelReason;
    private String detailCancelStatusLabel;
	
}
