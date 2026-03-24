package com.kh.jipshop.community.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Board {

    private int boardNo;
    private int memberNo;
    private int boardCode;
    private int categoryCode;

    private String boardTitle;
    private String boardContent;

    private int readCount;
    private Date createDate;
    private String boardActive;

    // 조회용 필드
    private String memberId;
    private int likeCount;
    private String thumbnailPath;
    private String categoryName;

    

    
}