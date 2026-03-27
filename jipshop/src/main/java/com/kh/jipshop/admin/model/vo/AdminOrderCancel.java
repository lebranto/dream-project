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

    private String stockRestoreLabel;  // 미복구 / 복구 완료
}