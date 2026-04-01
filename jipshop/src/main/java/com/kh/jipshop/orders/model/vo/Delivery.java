package com.kh.jipshop.orders.model.vo;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class Delivery {

	  private int deliveryId;
	    private int orderId;
	    private String courier;
	    private Date expectedDate;
	
}
