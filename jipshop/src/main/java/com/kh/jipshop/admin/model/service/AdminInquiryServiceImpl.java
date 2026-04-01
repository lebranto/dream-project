package com.kh.jipshop.admin.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.jipshop.admin.model.dao.AdminInquiryDao;
import com.kh.jipshop.admin.model.vo.AdminInquiry;

@Service
public class AdminInquiryServiceImpl implements AdminInquiryService{
	
	@Autowired
	private AdminInquiryDao adminInquiryDao;

	@Override
	public int getInquiryCount(Map<String, Object> paramMap) {
		return adminInquiryDao.getInquiryCount(paramMap);
	}

	@Override
	public List<AdminInquiry> getInquiryList(Map<String, Object> paramMap) {
		return adminInquiryDao.getInquiryList(paramMap);
	}
	
	
}
