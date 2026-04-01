package com.kh.jipshop.admin.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.jipshop.admin.model.vo.AdminInquiry;

@Repository
public class AdminInquiryDaoImpl implements AdminInquiryDao{
	
	@Autowired
    private SqlSessionTemplate session;
 
    private final String ns = "adminInquiry.";
 
    @Override
    public int getInquiryCount(Map<String, Object> paramMap) {
        return session.selectOne(ns + "getInquiryCount", paramMap);
    }
 
    @Override
    public List<AdminInquiry> getInquiryList(Map<String, Object> paramMap) {
        return session.selectList(ns + "getInquiryList", paramMap);
    }

	@Override
	public AdminInquiry getInquiryByNo(int inquiryId) {
		return session.selectOne(ns + "getInquiryByNo", inquiryId);
	}

	
}
