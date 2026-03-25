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
	public List<Orders> selectListOrder(Map<String, Object> paramMap) {
		
		return mDao.selectListOrder(paramMap);
	}

	@Override
	public int orderListCount(Map<String, Object> paramMap) {
	
		return mDao.orderListCount(paramMap);
	}

	
	
	// 최근 본 상품 조회 관련
	
	
	@Override
	public List<RecentlyViewed> selectListrecently(Map<String, Object> paramMap) {
		
		return mDao.selectListrecently(paramMap);
	}
	
	@Override
	public int recentlyListCount(Map<String, Object> paramMap) {
		
		return mDao.recentlyListCount(paramMap);
	}
	

	// 문의 글 관련
	
	
	@Override
	public List<MyInqury> inquiryList(Integer memberNo) {
		return mDao.inquiryList(memberNo);
	}

	
	
	


	



}
