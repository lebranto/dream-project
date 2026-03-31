package com.kh.jipshop.orders.model.vo;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class Status {
	
	private String dnum;
    private String deliveryYn;
    private String deliveryStatus;
    private int deliveryId;
    
}
