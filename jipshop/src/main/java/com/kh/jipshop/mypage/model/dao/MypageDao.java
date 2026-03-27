package com.kh.jipshop.mypage.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.jipshop.mypage.model.dto.OrderDetailResponse;
import com.kh.jipshop.mypage.model.vo.MyInqury;
import com.kh.jipshop.mypage.model.vo.Orders;
import com.kh.jipshop.mypage.model.vo.RecentlyViewed;

public interface MypageDao {

	
	List<OrderDetailResponse> selectListOrder(Map<String, Object> paramMap);
	
	int orderListCount(Map<String, Object> paramMap);	
	
	List<OrderDetailResponse> selectListrecently(Map<String, Object> paramMap);

	int recentlyListCount(Map<String, Object> paramMap);
		
	List<MyInqury> selectListinquiry(Map<String, Object> paramMap);

	int inquiryListCount(Map<String, Object> paramMap);

	MyInqury inquiryDetail(Integer inquiryId);

	int delectInquiry(MyInqury mi);

	OrderDetailResponse canclePage(Integer orderId);

	int canclePurchase(Orders orders);
	



	
	






}
