package com.kh.jipshop.mypage.model.dao;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.jipshop.common.model.vo.PageInfo;
import com.kh.jipshop.mypage.model.vo.MyInqury;
import com.kh.jipshop.mypage.model.vo.Orders;
import com.kh.jipshop.mypage.model.vo.RecentlyViewed;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class MypageDaoImpl implements MypageDao {

	private final SqlSessionTemplate session;
	
	// 구매 내역 조회 관련
	
	@Override
	public List<Orders> orderList(int memberId) {
		
		return session.selectList("mypage.orderList",memberId);
	}

	@Override
	public List<Orders> orderListPeriod(Integer memberNo, Integer period) {
		
		Map<String, Integer> map = new HashMap<>();
		map.put("period", period);
		map.put("memberNo", memberNo);
		
		return session.selectList("mypage.orderListPeriod",map);
	}

	@Override
	public List<Orders> orderListDate(Integer memberNo, Date startDate, Date endDate) {

		Map<String, Object> map = new HashMap<>();
		map.put("startDate", startDate);
		map.put("endDate", endDate);		
		map.put("memberNo", memberNo);
		
		
		return session.selectList("mypage.orderListDate",map);
	}
	
	
	// 최근 본 상품 조회 관련
	
	@Override
	public List<RecentlyViewed> recentlyList(Integer memberNo) {
		
		return session.selectList("mypage.recentlyList",memberNo);
	}

	@Override
	public List<RecentlyViewed> recentlyListPeriod(Integer memberNo, Integer period) {
		
		Map<String, Integer> map = new HashMap<>();
		map.put("period", period);
		map.put("memberNo", memberNo);
		
		return session.selectList("mypage.recentlyListPeriod",map);
	
	}
	
	
	@Override
	public List<RecentlyViewed> recentlyListDate(Integer memberNo, Date startDate, Date endDate) {
		
		Map<String, Object> map = new HashMap<>();
		map.put("startDate", startDate);
		map.put("endDate", endDate);		
		map.put("memberNo", memberNo);
		
		return session.selectList("mypage.recentlyListDate",map);
		
		
	}
	
	//문의 조회 관련

	@Override
	public List<MyInqury> inquiryList(Integer memberNo) {
		
		return session.selectList("mypage.inquiryList",memberNo);
	}
	
	
	
	//페이징 처리



}
