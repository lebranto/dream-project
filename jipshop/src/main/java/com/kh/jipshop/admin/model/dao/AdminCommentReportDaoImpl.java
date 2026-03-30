package com.kh.jipshop.admin.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.jipshop.admin.model.vo.AdminCommentReport;
import com.kh.jipshop.common.model.vo.PageInfo;

@Repository
public class AdminCommentReportDaoImpl implements AdminCommentReportDao {

    @Override
    public int selectReportListCount(SqlSessionTemplate sqlSession, HashMap<String, Object> paramMap) {
        return sqlSession.selectOne("adminCommentReportMapper.selectReportListCount", paramMap);
    }

    @Override
    public ArrayList<AdminCommentReport> selectReportList(SqlSessionTemplate sqlSession, PageInfo pi, HashMap<String, Object> paramMap) {

        int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
        int limit = pi.getBoardLimit();

        RowBounds rowBounds = new RowBounds(offset, limit);

        return (ArrayList)sqlSession.selectList(
                "adminCommentReportMapper.selectReportList",
                paramMap,
                rowBounds
        );
    }

    @Override
    public AdminCommentReport selectReportDetail(SqlSessionTemplate sqlSession, int reportId) {
        return sqlSession.selectOne("adminCommentReportMapper.selectReportDetail", reportId);
    }

    @Override
    public int updateReportProcess(SqlSessionTemplate sqlSession, int reportId) {
        return sqlSession.update("adminCommentReportMapper.updateReportProcess", reportId);
    }

    @Override
    public int updateBulkReportProcess(SqlSessionTemplate sqlSession, List<Integer> reportIds) {
        return sqlSession.update("adminCommentReportMapper.updateBulkReportProcess", reportIds);
    }

    @Override
    public int deleteBulkReport(SqlSessionTemplate sqlSession, List<Integer> reportIds) {
        return sqlSession.delete("adminCommentReportMapper.deleteBulkReport", reportIds);
    }

    @Override
    public int deactivateCommentByReportId(SqlSessionTemplate sqlSession, int reportId) {
        return sqlSession.update("adminCommentReportMapper.deactivateCommentByReportId", reportId);
    }

    @Override
    public int deactivateCommentsByReportIds(SqlSessionTemplate sqlSession, List<Integer> reportIds) {
        return sqlSession.update("adminCommentReportMapper.deactivateCommentsByReportIds", reportIds);
    }
}