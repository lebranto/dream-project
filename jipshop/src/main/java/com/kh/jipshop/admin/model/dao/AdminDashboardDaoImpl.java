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
	
	@Override
	public int getTodayOrderCount() {
		return session.selectOne("adminOrderMapper.getTodayOrderCount");
	}

	@Override
	public List<Map<String, Object>> getRecentOrderList() {
		return session.selectList("adminOrderMapper.getRecentOrderList");
	}

}
