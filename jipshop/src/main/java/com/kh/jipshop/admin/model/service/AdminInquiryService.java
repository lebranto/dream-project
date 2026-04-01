package com.kh.jipshop.admin.model.service;

import java.util.List;
import java.util.Map;

import com.kh.jipshop.admin.model.vo.AdminInquiry;

public interface AdminInquiryService {

	int getInquiryCount(Map<String, Object> paramMap);
	
    List<AdminInquiry> getInquiryList(Map<String, Object> paramMap);

	AdminInquiry getInquiryByNo(int inquiryId);

}
