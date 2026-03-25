package com.kh.jipshop.admin.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;
@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class AdminCommentReport {

    private int reportId;
    private int commentId;
    private String reportTypeName;
    private String reportReason;
    private Date reportDate;

    private int boardNo;
    private String commentContent;
    private Date commentRegDate;
    private String commentWriterId;

    
}