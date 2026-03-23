package com.kh.jipshop.mypage.model.dao;

import java.util.List;

import com.kh.jipshop.mypage.model.vo.Purchase;
import com.kh.jipshop.mypage.model.vo.RecentlyViewed;

public interface MypageDao {

	List<Purchase> orderList(int purchaseNo);

	List<RecentlyViewed> recentlyList(Integer viewId);



}
