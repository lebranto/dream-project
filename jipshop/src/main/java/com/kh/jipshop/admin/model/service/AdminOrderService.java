package com.kh.jipshop.admin.model.service;

import java.util.ArrayList;
import java.util.List;

import com.kh.jipshop.admin.model.vo.AdminOrder;
import com.kh.jipshop.admin.model.vo.AdminOrderSearch;
import com.kh.jipshop.common.model.vo.PageInfo;

public interface AdminOrderService {

    int selectOrderListCount(AdminOrderSearch search);

    ArrayList<AdminOrder> selectOrderList(PageInfo pi, AdminOrderSearch search);

    int deleteOrders(List<Integer> orderIds);

    int updateDeliveryYn(int orderId, String deliveryYn);

    AdminOrder selectOrderDetail(int orderId);

    ArrayList<AdminOrder> selectOrderDetailList(int orderId);

    int updateOrderStatus(int orderId, String orderStatus);

    int updateCancelStatusApproved(int detailId);

    int updateCancelStatusRejected(int detailId);

    int clearCancelStatus(int detailId);
}