package com.kh.jipshop.admin.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.jipshop.admin.model.dao.AdminDashboardDao;

@Service
public class AdminDashboardServiceImpl implements AdminDashboardService{
	@Autowired
	public AdminDashboardDao adminDashboardDao;
	
	@Override
	public int getTodayOrderCount() {
		return adminDashboardDao.getTodayOrderCount();
	}

	@Override
	public List<Map<String, Object>> getRecentOrderList() {
		return adminDashboardDao.getRecentOrderList();
	}

}
