package com.kh.jipshop.mypage.model.service;

import java.util.List;

import com.kh.jipshop.mypage.model.vo.Purchase;
import com.kh.jipshop.mypage.model.vo.RecentlyViewed;

public interface MypageService {

	List<Purchase> orderList(int orderNo);

	List<RecentlyViewed> recentlyList(Integer viewId);

	
}