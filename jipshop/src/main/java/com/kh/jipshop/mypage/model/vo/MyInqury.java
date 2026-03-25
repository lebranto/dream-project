package com.kh.jipshop.mypage.model.vo;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class MyInqury {
	
	private int inquiryId;
	private int memeberNo;
	private String inquiryType;
	private String inquiryContent;
	private String inquiryPhoto;
	private String inquiryPw;
	private Date inquiryRegDate;
	
	
	// 답변
	private String replyContent;
	private Date replyDate;
	private char replyYn;
	
	

}
