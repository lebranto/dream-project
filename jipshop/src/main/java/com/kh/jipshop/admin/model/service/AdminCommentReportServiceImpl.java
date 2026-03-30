package com.kh.jipshop.admin.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.jipshop.admin.model.dao.AdminCommentReportDao;
import com.kh.jipshop.admin.model.vo.AdminCommentReport;
import com.kh.jipshop.common.model.vo.PageInfo;

@Service
public class AdminCommentReportServiceImpl implements AdminCommentReportService {

    @Autowired
    private SqlSessionTemplate sqlSession;

    @Autowired
    private AdminCommentReportDao adminCommentReportDao;

    @Override
    public int selectReportListCount(HashMap<String, Object> paramMap) {
        return adminCommentReportDao.selectReportListCount(sqlSession, paramMap);
    }

    @Override
    public ArrayList<AdminCommentReport> selectReportList(PageInfo pi, HashMap<String, Object> paramMap) {
        return adminCommentReportDao.selectReportList(sqlSession, pi, paramMap);
    }

    @Override
    public AdminCommentReport selectReportDetail(int reportId) {
        return adminCommentReportDao.selectReportDetail(sqlSession, reportId);
    }

    @Override
    public int updateReportProcess(int reportId) {

        // 댓글 비활성화
        adminCommentReportDao.deactivateCommentByReportId(sqlSession, reportId);

        // 신고 처리 완료
        return adminCommentReportDao.updateReportProcess(sqlSession, reportId);
    }

    @Override
    public int updateBulkReportProcess(List<Integer> reportIds) {

        // 댓글들 비활성화
        adminCommentReportDao.deactivateCommentsByReportIds(sqlSession, reportIds);

        // 신고들 처리 완료
        return adminCommentReportDao.updateBulkReportProcess(sqlSession, reportIds);
    }

    @Override
    public int deleteBulkReport(List<Integer> reportIds) {
        return adminCommentReportDao.deleteBulkReport(sqlSession, reportIds);
    }
}