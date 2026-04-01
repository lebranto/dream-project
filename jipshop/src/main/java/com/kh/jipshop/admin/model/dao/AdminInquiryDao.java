package com.kh.jipshop.admin.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.jipshop.admin.model.vo.AdminInquiry;

public interface AdminInquiryDao {

	int getInquiryCount(Map<String, Object> paramMap);

	List<AdminInquiry> getInquiryList(Map<String, Object> paramMap);

	AdminInquiry getInquiryByNo(int inquiryId);

}
