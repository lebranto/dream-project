package com.kh.jipshop.admin.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;


import com.kh.jipshop.admin.model.vo.AdminOrder;
import com.kh.jipshop.admin.model.vo.AdminOrderSearch;
import com.kh.jipshop.common.model.vo.PageInfo;

@Repository
public class AdminOrderDaoImpl implements AdminOrderDao {

    @Override
    public int selectOrderListCount(SqlSessionTemplate sqlSession, AdminOrderSearch search) {
        return sqlSession.selectOne("adminOrderMapper.selectOrderListCount", search);
    }

    @Override
    public ArrayList<AdminOrder> selectOrderList(SqlSessionTemplate sqlSession, PageInfo pi, AdminOrderSearch search) {

        int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
        int limit = pi.getBoardLimit();

        RowBounds rowBounds = new RowBounds(offset, limit);

        java.util.List<AdminOrder> list = sqlSession.selectList(
                "adminOrderMapper.selectOrderList",
                search,
                rowBounds
        );

        return new ArrayList<>(list);
    }

    @Override
    public int updateDeliveryYn(SqlSessionTemplate sqlSession, HashMap<String, Object> map) {
        return sqlSession.update("adminOrderMapper.updateDeliveryYn", map);
    }

    @Override
    public int deleteStatusByOrderIds(SqlSessionTemplate sqlSession, ArrayList<Integer> orderIds) {
        return sqlSession.delete("adminOrderMapper.deleteStatusByOrderIds", orderIds);
    }

    @Override
    public int deleteDeliveryByOrderIds(SqlSessionTemplate sqlSession, ArrayList<Integer> orderIds) {
        return sqlSession.delete("adminOrderMapper.deleteDeliveryByOrderIds", orderIds);
    }

    @Override
    public int deleteOrderDetailByOrderIds(SqlSessionTemplate sqlSession, ArrayList<Integer> orderIds) {
        return sqlSession.delete("adminOrderMapper.deleteOrderDetailByOrderIds", orderIds);
    }

    @Override
    public int deleteOrdersByOrderIds(SqlSessionTemplate sqlSession, ArrayList<Integer> orderIds) {
        return sqlSession.delete("adminOrderMapper.deleteOrdersByOrderIds", orderIds);
    }
}