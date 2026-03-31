package com.kh.jipshop.product.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
@ToString
public class Products {

    private int productId;
    private int categoryId;
    private int companyCode;

    private String productName;
    private int productPrice;
    private int productStock;
    private String productDetail;

    private String productPhoto1;
    private String productPhoto2;

    private Date productRegDate;
    private String productActiveYn;

    private String petType;
    private String ageGroup;

    // 조인용 추가 필드
    private String companyName;
    private String categoryName;
    
    private int readCount;
}