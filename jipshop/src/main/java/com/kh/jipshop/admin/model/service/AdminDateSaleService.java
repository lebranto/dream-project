package com.kh.jipshop.admin.model.service;

import java.util.List;
import java.util.Map;

import com.kh.jipshop.mypage.model.dto.OrderDetailResponse;

public interface AdminDateSaleService {

	int salesListCount(Map<String, Object> paramMap);

	List<OrderDetailResponse> selectListSales(Map<String, Object> paramMap);

}
