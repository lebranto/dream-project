package com.kh.jipshop.admin.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AdminDashboardDaoImpl implements AdminDashboardDao{
	@Autowired
	private SqlSession session; 
	
	private String dash = "adminDashboard."; 
	@Override
	public int getTodayOrderCount() {
		return session.selectOne(dash+"getTodayOrderCount");
	}

	@Override
	public List<Map<String, Object>> getRecentOrderList() {
		return session.selectList(dash+"getRecentOrderList");
	}

	@Override
	public int getUnProReportCount() {
		return session.selectOne(dash+"getUnProReportCount");
	}

	@Override
	public List<Map<String, Object>> getRecentReportList() {
		return session.selectList(dash+"getRecentReportList");
	}

}
