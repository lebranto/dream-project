package com.kh.jipshop.mypage.model.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.jipshop.mypage.model.vo.Orders;
import com.kh.jipshop.mypage.model.vo.RecentlyViewed;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class MypageDaoImpl implements MypageDao {

	private final SqlSessionTemplate session;
	
	
	@Override
	public List<Orders> orderList(int orderNo) {
		
		return session.selectList("orderList",orderNo);
	}


	@Override
	public List<RecentlyViewed> recentlyList(Integer viewId) {
		
		return session.selectList("recentlyList",viewId);
	}

}
