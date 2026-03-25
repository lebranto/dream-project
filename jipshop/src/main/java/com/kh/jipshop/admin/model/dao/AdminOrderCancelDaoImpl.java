package com.kh.jipshop.admin.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.jipshop.admin.model.vo.AdminOrderCancel;
import com.kh.jipshop.admin.model.vo.AdminOrderSearch;
import com.kh.jipshop.common.model.vo.PageInfo;

@Repository
public class AdminOrderCancelDaoImpl implements AdminOrderCancelDao {

    @Override
    public int selectOrderCancelListCount(SqlSessionTemplate sqlSession, AdminOrderSearch search) {
        return sqlSession.selectOne("adminOrderMapper.selectOrderCancelAdminListCount", search);
    }

    @Override
    public ArrayList<AdminOrderCancel> selectOrderCancelList(SqlSessionTemplate sqlSession, PageInfo pi, AdminOrderSearch search) {

        int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
        int limit = pi.getBoardLimit();

        RowBounds rowBounds = new RowBounds(offset, limit);

        return (ArrayList)sqlSession.selectList("adminOrderMapper.selectOrderCancelAdminList", search, rowBounds);
    }

    @Override
    public int approveOrderCancel(SqlSessionTemplate sqlSession, ArrayList<Integer> orderIdList) {
        return sqlSession.update("adminOrderMapper.approveOrderCancelAdminByOrderIds", orderIdList);
    }

    @Override
    public int rejectOrderCancel(SqlSessionTemplate sqlSession, ArrayList<Integer> orderIdList) {
        return sqlSession.update("adminOrderMapper.rejectOrderCancelAdminByOrderIds", orderIdList);
    }

    @Override
    public int deleteStatusByOrderIds(SqlSessionTemplate sqlSession, ArrayList<Integer> orderIdList) {
        return sqlSession.delete("adminOrderMapper.deleteStatusByOrderIds", orderIdList);
    }

    @Override
    public int deleteDeliveryByOrderIds(SqlSessionTemplate sqlSession, ArrayList<Integer> orderIdList) {
        return sqlSession.delete("adminOrderMapper.deleteDeliveryByOrderIds", orderIdList);
    }

    @Override
    public int deleteOrderDetailByOrderIds(SqlSessionTemplate sqlSession, ArrayList<Integer> orderIdList) {
        return sqlSession.delete("adminOrderMapper.deleteOrderDetailByOrderIds", orderIdList);
    }

    @Override
    public int deleteOrdersByOrderIds(SqlSessionTemplate sqlSession, ArrayList<Integer> orderIdList) {
        return sqlSession.delete("adminOrderMapper.deleteOrdersByOrderIds", orderIdList);
    }
}