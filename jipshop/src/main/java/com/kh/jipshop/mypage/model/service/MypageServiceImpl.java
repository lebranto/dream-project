package com.kh.jipshop.mypage.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
	public OrderDetailResponse canclePage(Map<String, Object> paramMap) {
		
		return mDao.canclePage(paramMap);
	}

	    @Override
	    @Transactional
	    public int canclePurchase(Orders orders) {

	        // 1. 이미 취소된 상품인지 체크
	        int alreadyCanceled = mDao.checkDetailCanceled(orders);
	        if (alreadyCanceled > 0) {
	            return 0;
	        }

	        // 2. 취소할 금액 조회
	        int cancelAmount = mDao.selectCancelAmount(orders);
	        if (cancelAmount <= 0) {
	            return 0;
	        }

	        // 3. ORDER_DETAIL 취소 처리
	        int result1 = mDao.updateDetailCancel(orders);
	        if (result1 <= 0) {
	            return 0;
	        }

	        // 4. ORDERS 총금액 차감
	        int result2 = mDao.updateOrderTotalPrice(orders.getOrderId(), cancelAmount);
	        if (result2 <= 0) {
	            return 0;
	        }

	        // 5. 남은 미취소 상품 수 확인
	        int remainCount = mDao.countRemainDetails(orders.getOrderId());

	        // 6. 남은 상품이 없으면 ORDERS 전체 취소 처리
	        if (remainCount == 0) {
	            int result3 = mDao.updateOrderCancelComplete(orders);
	            if (result3 <= 0) {
	                return 0;
	            }
	        }

	        return 1;
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

	@Override
	public int saveOrUpdatePet(Pet p) {

        Pet existingPet = mDao.selectPetByMemberNo(p.getMemberNo());

        if (existingPet == null) {
            return mDao.insertPet(p);
        } else {
            p.setPetNo(existingPet.getPetNo());

            // 새 사진 안 올렸으면 기존 사진 유지
            if (p.getPetPhoto() == null || "".equals(p.getPetPhoto())) {
                p.setPetPhoto(existingPet.getPetPhoto());
            }

            return mDao.updatePet(p);
        }
    }


}
