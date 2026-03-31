package com.kh.jipshop.orders.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.jipshop.mypage.model.vo.Product;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class OrdersDaoImpl implements OrdersDao{
	
	
	private final SqlSessionTemplate session;
	

	@Override
	public List<Product> productList(Map<String, Object> paramMap) {
	
		return session.selectList("orders.productList", paramMap);
	}

}
