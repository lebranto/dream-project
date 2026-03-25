package com.kh.jipshop.community.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class BoardComment {

    private int commentId;
    private int boardNo;
    private int memberNo;
    private String memberId;
    private String commentContent;
    private Date commentRegDate;
    private String commentActiveYn;

    
}