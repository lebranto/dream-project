package com.kh.jipshop.product.model.vo;

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
public class ProductSearch {

    private String petType;        // 강아지 / 고양이
    private String categoryName;   // 사료 / 장난감 / 외출용품 / 미용용품
    private String sort;           // lowPrice / highPrice / readCount / latest
}