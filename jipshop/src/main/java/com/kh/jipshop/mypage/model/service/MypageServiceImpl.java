package com.kh.jipshop.mypage.model.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.kh.jipshop.mypage.model.dao.MypageDao;
import com.kh.jipshop.mypage.model.vo.Orders;
import com.kh.jipshop.mypage.model.vo.RecentlyViewed;

import lombok.RequiredArgsConstructor;


@Service
@RequiredArgsConstructor
public class MypageServiceImpl implements MypageService {
	
	private final MypageDao mDao;

	@Override
	public List<Orders> orderList(int orderNo) {
		
		return mDao.orderList(orderNo);
	}

	@Override
	public List<RecentlyViewed> recentlyList(Integer viewId) {

		return mDao.recentlyList(viewId);
	}


}
