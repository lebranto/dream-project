package com.kh.jipshop.mypage.model.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.kh.jipshop.mypage.model.dao.MypageDao;
import com.kh.jipshop.mypage.model.vo.MyInqury;
import com.kh.jipshop.mypage.model.vo.Orders;
import com.kh.jipshop.mypage.model.vo.RecentlyViewed;

import lombok.RequiredArgsConstructor;


@Service
@RequiredArgsConstructor
public class MypageServiceImpl implements MypageService {
	
	private final MypageDao mDao;

	
	// 구매 내역 조회 관련 
	
	@Override
	public List<Orders> orderList(int memberNo) {
		
		return mDao.orderList(memberNo);
	}

	@Override
	public List<Orders> orderListPeriod(Integer memberNo, Integer period) {
		
		return mDao.orderListPeriod(memberNo,period);
	}
	
	@Override
	public List<Orders> orderListDate(Integer memberNo, Date startDate, Date endDate) {
		
		return mDao.orderListDate(memberNo,startDate,endDate);
	}
	
	// 최근 본 상품 조회 관련
	
	@Override
	public List<RecentlyViewed> recentlyList(Integer memberNo) {

		return mDao.recentlyList(memberNo);
	}

	@Override
	public List<RecentlyViewed> recentlyListPeriod(Integer memberNo, Integer period) {
		return mDao.recentlyListPeriod(memberNo, period);
	}
	
	@Override
	public List<RecentlyViewed> recentlyListDate(Integer memberNo, Date startDate, Date endDate) {

		return mDao.recentlyListDate(memberNo,startDate, endDate);
	}

	
	// 문의 글 관련
	
	
	@Override
	public List<MyInqury> inquiryList(Integer memberNo) {
		return mDao.inquiryList(memberNo);
	}


	// 페이징 처리 쪽
	



}
