package com.kh.jipshop.admin.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.jipshop.admin.model.vo.AdminCommentReport;

@Repository
public class AdminCommentReportDaoImpl implements AdminCommentReportDao {

    @Override
    public AdminCommentReport selectDetail(SqlSessionTemplate sqlSession, int reportId) {
        return sqlSession.selectOne("adminCommentReportMapper.selectDetail", reportId);
    }

    @Override
    public ArrayList<AdminCommentReport> selectReportList(SqlSessionTemplate sqlSession) {
        List<AdminCommentReport> list = sqlSession.selectList("adminCommentReportMapper.selectReportList");
        return new ArrayList<>(list);
    }

    @Override
    public int deleteComment(SqlSessionTemplate sqlSession, int commentId) {
        return sqlSession.update("adminCommentReportMapper.deleteComment", commentId);
    }

    @Override
    public int updateReportStatus(SqlSessionTemplate sqlSession, int reportId) {
        return sqlSession.update("adminCommentReportMapper.updateReportStatus", reportId);
    }
}