package com.kh.jipshop.mypage.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.jipshop.common.model.vo.PageInfo;
import com.kh.jipshop.mypage.model.dto.OrderDetailResponse;
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
	public List<OrderDetailResponse> selectListOrder(Map<String, Object> paramMap) {
		/*
		 * 특정 페이지의 데이터를 가져오는 방법들(페이징 처리)
		 * 1. ROWNUM, ROW_NUMBER()로 페이징 처리된 쿼리 조회하기.
		 * SELECT *
		 * FROM (
		 * 	    SELECT ROWNUM AS RNUM , T.*
		 * 		FROM (
		 * 			SELECT ...
		 * 		) T
		 * )
		 * WHERE RNUM BETWEEN A AND B;
		 * 
		 * 2. OFFSET FETCH를 사용하여 쿼리 조회(오라클 12이상에서 사용가능)
		 *  - 코드의 복잡성을 줄이고 가독성을 크게 확보한 페이징 방식
		 *  SELECT
		 *  	...조회할 칼럼
		 * 	FROM 테이블
		 *  ...조건절
		 *  ORDER BY 절
		 *  OFFSET 시작행 ROWS FETCH NEXT 조회할 개수 ROWS ONLY
		 * 
		 *  */		
		
		// Rownum 이용
		PageInfo pi = (PageInfo) paramMap.get("pi");
		int offset = (pi.getCurrentPage() -1)*pi.getBoardLimit();
		int limit = pi.getBoardLimit();
		
		paramMap.put("offset",offset+1);
		paramMap.put("limit",limit+offset);
		
		return session.selectList("mypage.selectListOrder",paramMap);
	}

	@Override
	public int orderListCount(Map<String, Object> paramMap) {
		
		return session.selectOne("mypage.orderListCount",paramMap);
	}
	
	
	
	// 최근 본 상품 조회 관련
	

	@Override
	public List<OrderDetailResponse> selectListrecently(Map<String, Object> paramMap) {

		PageInfo pi = (PageInfo) paramMap.get("pi");
		int offset = (pi.getCurrentPage() -1)*pi.getBoardLimit();
		int limit = pi.getBoardLimit();
		
		paramMap.put("offset",offset+1);
		paramMap.put("limit",limit+offset);
		
		return session.selectList("mypage.selectListrecently",paramMap);
	}

	@Override
	public int recentlyListCount(Map<String, Object> paramMap) {
	
		return session.selectOne("mypage.recentlyListCount",paramMap);
	}

	
	//문의 관련


	@Override
	public List<MyInqury> selectListinquiry(Map<String, Object> paramMap) {
		
		PageInfo pi = (PageInfo) paramMap.get("pi");
		int offset = (pi.getCurrentPage() -1)*pi.getBoardLimit();
		int limit = pi.getBoardLimit();
		
		paramMap.put("offset",offset+1);
		paramMap.put("limit",limit+offset);
		
	
		return session.selectList("mypage.selectListinquiry",paramMap);
	}

	@Override
	public int inquiryListCount(Map<String, Object> paramMap) {
		
		return session.selectOne("mypage.inquiryListCount",paramMap);
	}

	@Override
	public MyInqury inquiryDetail(Integer inquiryId) {
		
		return session.selectOne("mypage.inquiryDetail",inquiryId);
	}

	@Override
	public int delectInquiry(MyInqury mi) {
	
		return session.delete("mypage.delectInquiry",mi);
	}

	
	
	// 구매 취소 관련
	
	@Override
	public OrderDetailResponse canclePage(Integer orderId) {
		
		return session.selectOne("mypage.canclePage",orderId);
	}

	@Override
	public int canclePurchase(Orders orders) {
		return session.update("mypage.canclePurchase", orders);
	}


	
	
	
	
	



}
