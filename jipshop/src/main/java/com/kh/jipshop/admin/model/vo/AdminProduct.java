package com.kh.jipshop.admin.model.vo;

import java.util.Date;
import lombok.Data;

@Data
public class AdminProduct {

    private int    productId;
    private int    categoryId;
    private String categoryName;   // JOIN
    private int    companyCode;
    private String companyName;    // JOIN
    private String productName;
    private int    productPrice;
    private int    productStock;
    private String productDetail;
    private String productPhoto1;
    private String productPhoto2;
    private Date   productRegDate;
    private String productActiveYn; // 'Y' 판매중 | 'N' 판매중지
    private String petType;
    private String ageGroup;
}