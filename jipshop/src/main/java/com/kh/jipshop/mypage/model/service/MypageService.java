package com.kh.jipshop.mypage.model.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import com.kh.jipshop.mypage.model.vo.MyInqury;
import com.kh.jipshop.mypage.model.vo.Orders;
import com.kh.jipshop.mypage.model.vo.RecentlyViewed;

public interface MypageService {

	List<Orders> orderList(int memberNo);
	
	List<Orders> orderListPeriod(Integer memberNo, Integer period);

	List<Orders> orderListDate(Integer memberNo, Date startDate, Date endDate);
	
	List<RecentlyViewed> recentlyList(Integer memberNo);

	List<RecentlyViewed> recentlyListPeriod(Integer memberNo, Integer period);

	List<RecentlyViewed> recentlyListDate(Integer memberNo, Date startDate, Date endDate);

	List<MyInqury> inquiryList(Integer memberNo);

	




	
}