package com.kh.jipshop.admin.model.service;

import java.util.ArrayList;

import com.kh.jipshop.admin.model.vo.AdminOrderSearch;
import com.kh.jipshop.common.model.vo.PageInfo;

public interface AdminOrderService {

	int selectOrderListCount(AdminOrderSearch search);

	Object selectOrderList(PageInfo pi, AdminOrderSearch search);

	int updateDeliveryYn(int orderId, String deliveryYn);

	int deleteOrders(ArrayList<Integer> orderIds);

}
