package com.kh.jipshop.inquiry.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class Inquiry {

    private int inquiryId;
    private int memberNo;
    private String inquiryType;
    private String inquiryContent;
    private String inquiryPhoto;
    private String inquiryPw;
    private Date inquiryRegDate;
    private String replyContent;
    private Date replyDate;
    private String replyYn;
}