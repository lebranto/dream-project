package com.kh.jipshop.admin.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

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

        return new ArrayList<>(sqlSession.selectList("adminOrderMapper.selectOrderList", search, rowBounds));
    }

    @Override
    public int deleteStatusByOrderIds(SqlSessionTemplate sqlSession, List<Integer> orderIds) {
        return sqlSession.delete("adminOrderMapper.deleteStatusByOrderIds", orderIds);
    }

    @Override
    public int deleteDeliveryByOrderIds(SqlSessionTemplate sqlSession, List<Integer> orderIds) {
        return sqlSession.delete("adminOrderMapper.deleteDeliveryByOrderIds", orderIds);
    }

    @Override
    public int deleteOrderDetailByOrderIds(SqlSessionTemplate sqlSession, List<Integer> orderIds) {
        return sqlSession.delete("adminOrderMapper.deleteOrderDetailByOrderIds", orderIds);
    }

    @Override
    public int deleteOrders(SqlSessionTemplate sqlSession, List<Integer> orderIds) {
        return sqlSession.delete("adminOrderMapper.deleteOrders", orderIds);
    }

    @Override
    public Integer selectDeliveryIdByOrderId(SqlSessionTemplate sqlSession, int orderId) {
        return sqlSession.selectOne("adminOrderMapper.selectDeliveryIdByOrderId", orderId);
    }

    @Override
    public int insertDelivery(SqlSessionTemplate sqlSession, int orderId) {
        return sqlSession.insert("adminOrderMapper.insertDelivery", orderId);
    }

    @Override
    public Integer selectLatestDeliveryIdByOrderId(SqlSessionTemplate sqlSession, int orderId) {
        return sqlSession.selectOne("adminOrderMapper.selectLatestDeliveryIdByOrderId", orderId);
    }

    @Override
    public Integer selectStatusCountByDeliveryId(SqlSessionTemplate sqlSession, int deliveryId) {
        return sqlSession.selectOne("adminOrderMapper.selectStatusCountByDeliveryId", deliveryId);
    }

    @Override
    public int updateLatestStatus(SqlSessionTemplate sqlSession, HashMap<String, Object> map) {
        return sqlSession.update("adminOrderMapper.updateLatestStatus", map);
    }

    @Override
    public int insertStatus(SqlSessionTemplate sqlSession, HashMap<String, Object> map) {
        return sqlSession.insert("adminOrderMapper.insertStatus", map);
    }

    @Override
    public AdminOrder selectOrderDetail(SqlSessionTemplate sqlSession, int orderId) {
        return sqlSession.selectOne("adminOrderMapper.selectOrderDetail", orderId);
    }

    @Override
    public int updateCancelStatus(SqlSessionTemplate sqlSession, int orderId) {
        return sqlSession.update("adminOrderMapper.updateCancelStatus", orderId);
    }

    @Override
    public int clearCancelStatus(SqlSessionTemplate sqlSession, int orderId) {
        return sqlSession.update("adminOrderMapper.clearCancelStatus", orderId);
    }
}