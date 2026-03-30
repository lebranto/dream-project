package com.kh.jipshop.admin.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class AdminCommentReport {

    private int reportId;
    private int reporterMemberNo;
    private int commentId;
    private int reportTypeId;

    private String reportReason;
    private String reportDate;
    private String reportProcessYn;

    // 목록/상세 조회용
    private String reporterId;        // 신고자 MEMBER_ID
    private int boardNo;              // 신고대상 = BOARD_NO
    private String reportTypeName;    // 신고유형
    private String commentContent;    // 신고된 댓글 내용

    // 화면 표시용
    private String reportStatus;     
    private String processLabel;      // 처리 대기 / 처리 완료
}