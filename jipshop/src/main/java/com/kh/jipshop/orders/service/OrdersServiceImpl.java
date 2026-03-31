package com.kh.jipshop.orders.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.kh.jipshop.mypage.model.vo.Product;
import com.kh.jipshop.orders.dao.OrdersDao;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class OrdersServiceImpl implements OrdersService{

	private final OrdersDao oDao;
	
	@Override
	public List<Product> productList(Map<String, Object> paramMap) {
		
		return oDao.productList(paramMap);
	}

}
