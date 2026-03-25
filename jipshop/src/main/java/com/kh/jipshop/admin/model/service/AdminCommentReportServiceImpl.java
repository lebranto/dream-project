package com.kh.jipshop.admin.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.jipshop.admin.model.dao.AdminCommentReportDao;
import com.kh.jipshop.admin.model.vo.AdminCommentReport;

@Service
public class AdminCommentReportServiceImpl implements AdminCommentReportService {

    @Autowired
    private AdminCommentReportDao dao;

    @Autowired
    private SqlSessionTemplate sqlSession;

    @Override
    public AdminCommentReport selectDetail(int reportId) {
        return dao.selectDetail(sqlSession, reportId);
    }

    @Override
    public ArrayList<AdminCommentReport> selectReportList() {
        return dao.selectReportList(sqlSession);
    }

    @Override
    public int deleteComment(int commentId, int reportId) {

        int result1 = dao.deleteComment(sqlSession, commentId);
        int result2 = dao.updateReportStatus(sqlSession, reportId);

        return result1 * result2;
    }
}