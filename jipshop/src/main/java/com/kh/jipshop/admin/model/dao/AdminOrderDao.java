package com.kh.jipshop.admin.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import com.kh.jipshop.admin.model.vo.AdminOrder;
import com.kh.jipshop.admin.model.vo.AdminOrderSearch;
import com.kh.jipshop.common.model.vo.PageInfo;

public interface AdminOrderDao {

    int selectOrderListCount(SqlSessionTemplate sqlSession, AdminOrderSearch search);

    ArrayList<AdminOrder> selectOrderList(SqlSessionTemplate sqlSession, PageInfo pi, AdminOrderSearch search);

    int deleteStatusByOrderIds(SqlSessionTemplate sqlSession, List<Integer> orderIds);

    int deleteDeliveryByOrderIds(SqlSessionTemplate sqlSession, List<Integer> orderIds);

    int deleteOrderDetailByOrderIds(SqlSessionTemplate sqlSession, List<Integer> orderIds);

    int deleteOrders(SqlSessionTemplate sqlSession, List<Integer> orderIds);

    Integer selectDeliveryIdByOrderId(SqlSessionTemplate sqlSession, int orderId);

    int insertDelivery(SqlSessionTemplate sqlSession, int orderId);

    Integer selectLatestDeliveryIdByOrderId(SqlSessionTemplate sqlSession, int orderId);

    Integer selectStatusCountByDeliveryId(SqlSessionTemplate sqlSession, int deliveryId);

    int updateLatestStatus(SqlSessionTemplate sqlSession, HashMap<String, Object> map);

    int insertStatus(SqlSessionTemplate sqlSession, HashMap<String, Object> map);

    AdminOrder selectOrderDetail(SqlSessionTemplate sqlSession, int orderId);

    ArrayList<AdminOrder> selectOrderDetailList(SqlSessionTemplate sqlSession, int orderId);

    int updateCancelStatus(SqlSessionTemplate sqlSession, int detailId);

    int clearCancelStatus(SqlSessionTemplate sqlSession, int detailId);

    int updateCancelStatusApproved(SqlSessionTemplate sqlSession, int detailId);

    int updateCancelStatusRejected(SqlSessionTemplate sqlSession, int detailId);
}