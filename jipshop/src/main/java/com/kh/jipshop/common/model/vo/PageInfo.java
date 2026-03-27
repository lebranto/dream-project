package com.kh.jipshop.common.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class PageInfo {

    private int listCount;      // 총 게시글 수
    private int currentPage;    // 현재 페이지
    private int pageLimit;      // 페이징 바에 보여질 페이지 수
    private int boardLimit;     // 한 페이지에 보여질 게시글 수

    private int maxPage;        // 가장 마지막 페이지
    private int startPage;      // 페이징 바 시작 페이지
    private int endPage;        // 페이징 바 끝 페이지

   
}