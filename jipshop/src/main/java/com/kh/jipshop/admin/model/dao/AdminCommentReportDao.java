package com.kh.jipshop.admin.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;

import com.kh.jipshop.admin.model.vo.AdminCommentReport;

public interface AdminCommentReportDao {

	AdminCommentReport selectDetail(SqlSessionTemplate sqlSession, int reportId);

	ArrayList<AdminCommentReport> selectReportList(SqlSessionTemplate sqlSession);

	int deleteComment(SqlSessionTemplate sqlSession, int commentId);

	int updateReportStatus(SqlSessionTemplate sqlSession, int reportId);



}
