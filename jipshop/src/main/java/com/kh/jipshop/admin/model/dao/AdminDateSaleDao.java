package com.kh.jipshop.admin.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.jipshop.mypage.model.dto.OrderDetailResponse;

public interface AdminDateSaleDao {

	int salesListCount(Map<String, Object> paramMap);

	List<OrderDetailResponse> selectListSales(Map<String, Object> paramMap);

}
