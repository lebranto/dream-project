package com.kh.jipshop.admin.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.kh.jipshop.admin.controller.AdminDateSaleController;
import com.kh.jipshop.admin.model.dao.AdminDateSaleDao;
import com.kh.jipshop.mypage.model.dto.OrderDetailResponse;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AdminDateSaleServiceImpl implements AdminDateSaleService{
	
	
	
	public final AdminDateSaleDao aDao;
	
	
	@Override
	public int salesListCount(Map<String, Object> paramMap) {
		return aDao.salesListCount(paramMap);
	}

	@Override
	public List<OrderDetailResponse> selectListSales(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return aDao.selectListSales(paramMap);
	}

}
