package com.kh.jipshop.admin.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.jipshop.admin.model.vo.AdminOrderCancel;
import com.kh.jipshop.admin.model.vo.AdminOrderCancelSearch;
import com.kh.jipshop.common.model.vo.PageInfo;

@Repository
public class AdminOrderCancelDaoImpl implements AdminOrderCancelDao {

    @Override
    public int selectOrderCancelListCount(SqlSessionTemplate sqlSession, AdminOrderCancelSearch search) {
        return sqlSession.selectOne("adminOrderMapper.selectOrderCancelListCount", search);
    }

    @Override
    public ArrayList<AdminOrderCancel> selectOrderCancelList(SqlSessionTemplate sqlSession, PageInfo pi, AdminOrderCancelSearch search) {

        int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
        int limit = pi.getBoardLimit();

        RowBounds rowBounds = new RowBounds(offset, limit);

        return (ArrayList)sqlSession.selectList(
                "adminOrderMapper.selectOrderCancelList",
                search,
                rowBounds
        );
    }

    @Override
    public int selectPendingCancelCount(SqlSessionTemplate sqlSession) {
        return sqlSession.selectOne("adminOrderMapper.selectPendingCancelCount");
    }

    @Override
    public int updateCancelStatusApproved(SqlSessionTemplate sqlSession, int orderId) {
        return sqlSession.update("adminOrderMapper.updateCancelStatusApproved", orderId);
    }

    @Override
    public int updateCancelStatusRejected(SqlSessionTemplate sqlSession, int orderId) {
        return sqlSession.update("adminOrderMapper.updateCancelStatusRejected", orderId);
    }
}