package com.kh.jipshop.mypage.model.dao;

import java.util.List;

import com.kh.jipshop.mypage.model.vo.Orders;
import com.kh.jipshop.mypage.model.vo.RecentlyViewed;

public interface MypageDao {

	List<Orders> orderList(int memberNo);

	List<RecentlyViewed> recentlyList(Integer viewId);

	List<RecentlyViewed> inquiryList(Integer inquiryId);



}
