package com.kh.jipshop.admin.model.service;

import java.util.ArrayList;

import com.kh.jipshop.admin.model.vo.AdminOrderCancel;
import com.kh.jipshop.admin.model.vo.AdminOrderCancelSearch;
import com.kh.jipshop.admin.model.vo.AdminOrderSearch;
import com.kh.jipshop.common.model.vo.PageInfo;

public interface AdminOrderCancelService {

	int selectOrderCancelListCount(AdminOrderCancelSearch search);

	ArrayList<AdminOrderCancel> selectOrderCancelList(PageInfo pi, AdminOrderCancelSearch search);

	int selectPendingCancelCount();

	int approveCancel(int orderId);

	int rejectCancel(int orderId);

	

	
}
