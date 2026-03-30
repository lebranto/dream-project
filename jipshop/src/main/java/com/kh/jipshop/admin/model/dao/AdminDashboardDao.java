package com.kh.jipshop.admin.model.dao;

import java.util.List;
import java.util.Map;

public interface AdminDashboardDao {

	int getTodayOrderCount();

	List<Map<String, Object>> getRecentOrderList();

}
