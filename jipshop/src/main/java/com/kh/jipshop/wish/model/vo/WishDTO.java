package com.kh.jipshop.wish.model.vo;

import lombok.Data;

@Data
public class WishDTO {

    private int wishId;
    private int memberNo;

    private int productId;
    private String productName;
    private int productPrice;
    private String productPhoto1;
}