package com.kh.jipshop.admin.model.service;

import java.util.List;
import java.util.Map;

import com.kh.jipshop.mypage.model.dto.OrderDetailResponse;
import com.kh.jipshop.mypage.model.vo.Orders;

public interface AdminDateSaleService {

	// 월별 조회
	int monthListCount(Map<String, Object> paramMap);

	List<Orders> selectListMonth(Map<String, Object> paramMap);

	// 월별 통계
	
	int selectTotalMonth(Map<String, Object> paramMap);
	
	int selectTotalCountMonth(Map<String, Object> paramMap);
	
	
	//일별 조회
	int dateListCount(Map<String, Object> paramMap);

	List<Orders> selectListDate(Map<String, Object> paramMap);

	//일별 통계
	int selectTotalDate(Map<String, Object> paramMap);

	int selectTotalCountDate(Map<String, Object> paramMap);



}
