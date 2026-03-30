package com.kh.jipshop.admin.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import com.kh.jipshop.admin.model.vo.AdminCommentReport;
import com.kh.jipshop.common.model.vo.PageInfo;

public interface AdminCommentReportDao {

    int selectReportListCount(SqlSessionTemplate sqlSession, HashMap<String, Object> paramMap);

    ArrayList<AdminCommentReport> selectReportList(SqlSessionTemplate sqlSession, PageInfo pi, HashMap<String, Object> paramMap);

    AdminCommentReport selectReportDetail(SqlSessionTemplate sqlSession, int reportId);

    int updateReportProcess(SqlSessionTemplate sqlSession, int reportId);

    int updateBulkReportProcess(SqlSessionTemplate sqlSession, List<Integer> reportIds);

    int deleteBulkReport(SqlSessionTemplate sqlSession, List<Integer> reportIds);

    int deactivateCommentByReportId(SqlSessionTemplate sqlSession, int reportId);

    int deactivateCommentsByReportIds(SqlSessionTemplate sqlSession, List<Integer> reportIds);
}