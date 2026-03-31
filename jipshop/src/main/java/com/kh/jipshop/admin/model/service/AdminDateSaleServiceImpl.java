package com.kh.jipshop.admin.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.kh.jipshop.admin.controller.AdminDateSaleController;
import com.kh.jipshop.admin.model.dao.AdminDateSaleDao;
import com.kh.jipshop.mypage.model.dto.OrderDetailResponse;
import com.kh.jipshop.mypage.model.vo.Orders;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AdminDateSaleServiceImpl implements AdminDateSaleService{
	
	
	
	public final AdminDateSaleDao aDao;
	
	
	// 월별 조회
	
	@Override
	public int monthListCount(Map<String, Object> paramMap) {
		return aDao.monthListCount(paramMap);
	}

	@Override
	public List<OrderDetailResponse> selectListMonth(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return aDao.selectListMonth(paramMap);
	}

	
	//월별 통계
	
	@Override
	public int selectTotalMonth(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return aDao.selectTotalMonth(paramMap);
	}

	@Override
	public int selectTotalCountMonth(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return aDao.selectTotalCountMonth(paramMap);
	}

	
	
	// 일별 조회
	
	@Override
	public int dateListCount(Map<String, Object> paramMap) {
		
		return aDao.dateListCount(paramMap);
	}

	@Override
	public List<OrderDetailResponse> selectListDate(Map<String, Object> paramMap) {
	
		return aDao.selectListDate(paramMap);
	}
	
	// 일별 통계
	
	@Override
	public int selectTotalDate(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return aDao.selectTotalDate(paramMap);
	}

	@Override
	public int selectTotalCountDate(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return aDao.selectTotalCountDate(paramMap);
	}

	

	

}
