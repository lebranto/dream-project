package com.kh.jipshop.admin.model.service;

import java.util.List;
import java.util.Map;

public interface AdminDashboardService {

	int getTodayOrderCount();

	List<Map<String, Object>> getRecentOrderList();

	int getUnProReportCount();

	List<Map<String, Object>> getRecentReportList();

	int getUnproInquiryCount();

	List<Map<String, Object>> getRecentInquiryList();

}
