package com.kh.jipshop.admin.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.jipshop.mypage.model.dto.OrderDetailResponse;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class AdminDateSaleDaoImpl implements AdminDateSaleDao{

	private final SqlSessionTemplate session;

	@Override
	public List<OrderDetailResponse> selectListSales(Map<String, Object> paramMap) {
		
		return session.selectList("adminSaleMapper.selectListSales",paramMap);
	}
	
	@Override
	public int salesListCount(Map<String, Object> paramMap) {
	
		return session.selectOne("adminSaleMapper.salesListCount",paramMap);
	}
	
}
