package com.kh.jipshop.orders.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.jipshop.mypage.model.vo.OrderDetail;
import com.kh.jipshop.mypage.model.vo.Orders;
import com.kh.jipshop.mypage.model.vo.Product;
import com.kh.jipshop.orders.model.vo.Delivery;
import com.kh.jipshop.orders.model.vo.Status;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class OrdersDaoImpl implements OrdersDao{
	
	
	private final SqlSessionTemplate session;
	

	@Override
	public List<Product> productList(Map<String, Object> paramMap) {
	
		return session.selectList("orders.productList", paramMap);
	}

	
	// 구매 내역 넣기

	 @Override
	    public int insertOrders(Orders order) {
	        return session.insert("orders.insertOrders", order);
	 }

	 @Override
	 public int insertOrderDetail(OrderDetail detail) {
	        return session.insert("orders.insertOrderDetail", detail);
	 }


	 @Override
	    public int insertDelivery(Delivery delivery) {
	        return session.insert("orders.insertDelivery", delivery);
	    }

	    @Override
	    public int insertStatus(Status status) {
	        return session.insert("orders.insertStatus", status);
	    }

}
