package com.kh.jipshop.admin.model.vo;

import java.util.Date;
import lombok.Data;

@Data
public class AdminInquiry {
	 private int inquiryId;
	    private int memberNo;
	    private String memberName;
	    private String memberId;
	    private String inquiryType;
	    private String inquiryContent;
	    private String inquiryPhoto;
	    private String inquiryPw;
	    private Date inquiryRegDate;
	    private String replyContent;
	    private Date replyDate;
	    private String replyYn;
}
