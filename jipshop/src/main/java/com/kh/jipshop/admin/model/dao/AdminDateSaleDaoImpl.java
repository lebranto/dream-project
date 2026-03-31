package com.kh.jipshop.admin.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.jipshop.mypage.model.dto.OrderDetailResponse;
import com.kh.jipshop.mypage.model.vo.Orders;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class AdminDateSaleDaoImpl implements AdminDateSaleDao{

	private final SqlSessionTemplate session;

	
	// 월별
	
	@Override
	public List<OrderDetailResponse> selectListMonth(Map<String, Object> paramMap) {
		
		return session.selectList("adminSaleMapper.selectListMonth",paramMap);
	}
	
	@Override
	public int monthListCount(Map<String, Object> paramMap) {
	
		return session.selectOne("adminSaleMapper.monthListCount",paramMap);
	}
	
	@Override
	public int selectTotalMonth(Map<String, Object> paramMap) {

		return session.selectOne("adminSaleMapper.selectTotalMonth",paramMap);
	}

	@Override
	public int selectTotalCountMonth(Map<String, Object> paramMap) {
		
		return session.selectOne("adminSaleMapper.selectTotalCountMonth",paramMap);
	}
	
	
	
	//일별
	@Override
	public List<OrderDetailResponse> selectListDate(Map<String, Object> paramMap) {

		return session.selectList("adminSaleMapper.selectListDate",paramMap);
	}
	
	@Override
	public int dateListCount(Map<String, Object> paramMap) {
		return session.selectOne("adminSaleMapper.dateListCount",paramMap);
	}

	@Override
	public int selectTotalDate(Map<String, Object> paramMap) {
		return session.selectOne("adminSaleMapper.selectTotalDate",paramMap);
	}

	@Override
	public int selectTotalCountDate(Map<String, Object> paramMap) {
		// TODO Auto-generated method stub
		return session.selectOne("adminSaleMapper.selectTotalCountDate",paramMap);
	}

	
	
}
