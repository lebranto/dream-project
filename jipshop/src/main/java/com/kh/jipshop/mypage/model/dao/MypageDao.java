package com.kh.jipshop.mypage.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.jipshop.member.model.vo.Member;
import com.kh.jipshop.member.model.vo.Pet;
import com.kh.jipshop.mypage.model.dto.OrderDetailResponse;
import com.kh.jipshop.mypage.model.vo.MyInqury;
import com.kh.jipshop.mypage.model.vo.Orders;
import com.kh.jipshop.mypage.model.vo.RecentlyViewed;

public interface MypageDao {

	
	List<OrderDetailResponse> selectListOrder(Map<String, Object> paramMap);
	
	int orderListCount(Map<String, Object> paramMap);	
	
	List<OrderDetailResponse> selectListrecently(Map<String, Object> paramMap);

	int recentlyListCount(Map<String, Object> paramMap);
		
	List<MyInqury> selectListinquiry(Map<String, Object> paramMap);

	int inquiryListCount(Map<String, Object> paramMap);

	MyInqury inquiryDetail(Integer inquiryId);

	int delectInquiry(MyInqury mi);

	OrderDetailResponse canclePage(Integer orderId);

	int checkDetailCanceled(Orders orders);
	
	int selectCancelAmount(Orders orders);
	
	int updateDetailCancel(Orders orders);
	
	int updateOrderTotalPrice(int orderId, int cancelAmount);
	
	int countRemainDetails(int orderId);
	
	int updateOrderCancelComplete(Orders orders);

	int memberDeleteOk(Member m);

	int updateMember(Member m);

	int updatePet(Pet p);

	
	
	



	
	






}
