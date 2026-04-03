package com.kh.jipshop.cart.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class CartDTO {
    private int cartId;
    private int memberNo;      // DB의 MEMBER_NO와 매칭
    private int productId;
    private int cartQty;
    
    // JOIN을 통해 PRODUCT 테이블에서 가져올 필드들
    private String productName;
    private int productPrice;
    private String productPhoto1;
}