package com.kh.jipshop.orders.service;

import java.util.List;
import java.util.Map;

import com.kh.jipshop.mypage.model.vo.Product;

public interface OrdersService {

	List<Product> productList(Map<String, Object> paramMap);

}
