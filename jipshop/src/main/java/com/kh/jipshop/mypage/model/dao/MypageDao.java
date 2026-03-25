package com.kh.jipshop.mypage.model.dao;

import java.util.Date;
import java.util.List;
import java.util.Map;

import com.kh.jipshop.mypage.model.vo.MyInqury;
import com.kh.jipshop.mypage.model.vo.Orders;
import com.kh.jipshop.mypage.model.vo.RecentlyViewed;

public interface MypageDao {

	
	List<Orders> selectListOrder(Map<String, Object> paramMap);
	
	int orderListCount(Map<String, Object> paramMap);	
	
	List<RecentlyViewed> selectListrecently(Map<String, Object> paramMap);

	int recentlyListCount(Map<String, Object> paramMap);
	
	List<MyInqury> inquiryList(Integer memberNo);


	
	






}
