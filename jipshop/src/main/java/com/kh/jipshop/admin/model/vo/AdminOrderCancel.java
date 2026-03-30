package com.kh.jipshop.admin.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class AdminOrderCancel {

    private int orderId;
    private String ordererName;
    private String productName;

    private String cancelReason;
    private String cancelRequestDateStr;

    private String orderCancelYn;
    private String cancelStatus;       // PENDING / APPROVED / REJECTED
    private String cancelStatusLabel;  // 승인 대기 / 취소 승인 / 취소 반려

    // 추가
    private String deliveryStatus;      // 준비중 / 배송중 / 배송완료
    private String responsibilityType;  // 사용자 귀책 / 판매자 귀책 / 확인 필요
    private String shippingFeePolicy;   // 배송비 없음 / 배송비 부과 / 배송비 면제 / 확인 필요
}