package com.kh.jipshop.orders.dao;

import java.util.List;
import java.util.Map;

import com.kh.jipshop.mypage.model.vo.OrderDetail;
import com.kh.jipshop.mypage.model.vo.Orders;
import com.kh.jipshop.mypage.model.vo.Product;
import com.kh.jipshop.orders.model.vo.Delivery;
import com.kh.jipshop.orders.model.vo.Status;

public interface OrdersDao {

	List<Product> productList(Map<String, Object> paramMap);

	int insertOrders(Orders order);

	int insertOrderDetail(OrderDetail detail);

	int insertDelivery(Delivery delivery);

	int insertStatus(Status status);

}
