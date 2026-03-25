package com.kh.jipshop.admin.model.service;

import java.util.ArrayList;

import com.kh.jipshop.admin.model.vo.AdminOrderCancel;
import com.kh.jipshop.admin.model.vo.AdminOrderSearch;
import com.kh.jipshop.common.model.vo.PageInfo;

public interface AdminOrderCancelService {

	int selectOrderCancelListCount(AdminOrderSearch search);

	ArrayList<AdminOrderCancel> selectOrderCancelList(PageInfo pi, AdminOrderSearch search);

	int approveOrderCancel(String orderIds);

	int rejectOrderCancel(String orderIds);

	int deleteOrderCancel(String orderIds);

	
}
