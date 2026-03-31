package com.kh.jipshop.orders.dao;

import java.util.List;
import java.util.Map;

import com.kh.jipshop.mypage.model.vo.Product;

public interface OrdersDao {

	List<Product> productList(Map<String, Object> paramMap);

}
