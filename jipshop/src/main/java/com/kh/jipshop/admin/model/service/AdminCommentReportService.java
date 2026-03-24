package com.kh.jipshop.admin.model.service;

import java.util.ArrayList;

import com.kh.jipshop.admin.model.vo.AdminCommentReport;

public interface AdminCommentReportService {

	AdminCommentReport selectDetail(int reportId);

	ArrayList<AdminCommentReport> selectReportList();

	int deleteComment(int commentId, int reportId);

	
	
	
	
}