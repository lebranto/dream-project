package com.kh.jipshop.admin.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.jipshop.mypage.model.dto.OrderDetailResponse;
import com.kh.jipshop.mypage.model.vo.Orders;

public interface AdminDateSaleDao {

	
	//월별
	int monthListCount(Map<String, Object> paramMap);

	List<OrderDetailResponse> selectListMonth(Map<String, Object> paramMap);
	
	int selectTotalMonth(Map<String, Object> paramMap);

	int selectTotalCountMonth(Map<String, Object> paramMap);
	
	
	
	//일별

	int dateListCount(Map<String, Object> paramMap);

	List<OrderDetailResponse> selectListDate(Map<String, Object> paramMap);

	int selectTotalDate(Map<String, Object> paramMap);

	int selectTotalCountDate(Map<String, Object> paramMap);

	

}
