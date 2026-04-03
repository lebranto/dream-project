package com.kh.jipshop.mypage.model.vo;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class Product {
	
	private int productId;
	private int categoryId;
	private int companyCode;
	private String productName;
	private int price;
	private int stock;
	private String detail;
	private String photo1;
	private String photo2;
	private Date productRegDate;
	private char activeYn; // 품절 여부
	private String petType;
	private String ageGroup;
	
	private int qty;
	
	
	
	
	

}
