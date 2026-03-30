package com.kh.jipshop.mypage.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.kh.jipshop.member.model.vo.Member;
import com.kh.jipshop.member.model.vo.Pet;
import com.kh.jipshop.mypage.model.dao.MypageDao;
import com.kh.jipshop.mypage.model.dto.OrderDetailResponse;
import com.kh.jipshop.mypage.model.vo.MyInqury;
import com.kh.jipshop.mypage.model.vo.Orders;

import lombok.RequiredArgsConstructor;


@Service
@RequiredArgsConstructor
public class MypageServiceImpl implements MypageService {
	
	private final MypageDao mDao;

	
	// 구매 내역 조회 관련 
	

	@Override
	public List<OrderDetailResponse> selectListOrder(Map<String, Object> paramMap) {
		
		return mDao.selectListOrder(paramMap);
	}

	@Override
	public int orderListCount(Map<String, Object> paramMap) {
	
		return mDao.orderListCount(paramMap);
	}

	
	
	// 최근 본 상품 조회 관련
	
	
	@Override
	public List<OrderDetailResponse> selectListrecently(Map<String, Object> paramMap) {
		
		return mDao.selectListrecently(paramMap);
	}
	
	@Override
	public int recentlyListCount(Map<String, Object> paramMap) {
		
		return mDao.recentlyListCount(paramMap);
	}

	// 문의 글 관련
	
	@Override
	public List<MyInqury> selectListinquiry(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return mDao.selectListinquiry(paramMap);
	}

	@Override
	public int inquiryListCount(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return mDao.inquiryListCount(paramMap);
	}

	@Override
	public MyInqury inquiryDetail(Integer inquiryId) {
		
		return mDao.inquiryDetail(inquiryId);
	}

	@Override
	public int delectInquiry(MyInqury mi) {
		
		return mDao.delectInquiry(mi);
	}

	
	// 구매 취소페이지
	
	@Override
	public OrderDetailResponse canclePage(Integer orderId) {
		
		return mDao.canclePage(orderId);
	}

	@Override
	public int canclePurchase(Orders orders) {
		return mDao.canclePurchase(orders);
	}

	@Override
	public int memberDeleteOk(Member m) {
		return mDao.memberDeleteOk(m);
	}

	@Override
	public int updateMember(Member m) {
		return mDao.updateMember(m);
	}

	@Override
	public int updatePet(Pet p) {
		
		return mDao.updatePet(p);
	}
	

	
	

	

	
	
	


	



}
