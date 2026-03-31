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

	private String reporterId;
	private int reportedMemberNo;
	private String reportedMemberId;
	private int boardNo;
	private String reportTypeName;
	private String commentContent;
	private String reportStatus;
	private String processLabel;    // 처리 대기 / 처리 완료
}