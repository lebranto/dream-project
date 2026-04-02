package com.kh.jipshop.admin.model.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.jipshop.admin.model.dao.AdminOrderDao;
import com.kh.jipshop.admin.model.vo.AdminOrder;
import com.kh.jipshop.admin.model.vo.AdminOrderSearch;
import com.kh.jipshop.common.model.vo.PageInfo;

@Service
public class AdminOrderServiceImpl implements AdminOrderService {

    @Autowired
    private SqlSessionTemplate sqlSession;

    @Autowired
    private AdminOrderDao adminOrderDao;

    @Override
    public int selectOrderListCount(AdminOrderSearch search) {
        return adminOrderDao.selectOrderListCount(sqlSession, search);
    }

    @Override
    public ArrayList<AdminOrder> selectOrderList(PageInfo pi, AdminOrderSearch search) {
        ArrayList<AdminOrder> list = adminOrderDao.selectOrderList(sqlSession, pi, search);

        int rowNum = (pi.getCurrentPage() - 1) * pi.getBoardLimit() + 1;
        for (AdminOrder order : list) {
            order.setRowNum(rowNum++);
        }

        return list;
    }

    @Override
    @Transactional
    public int deleteOrders(List<Integer> orderIds) {
        if (orderIds == null || orderIds.isEmpty()) {
            return 0;
        }

        adminOrderDao.deleteStatusByOrderIds(sqlSession, orderIds);
        adminOrderDao.deleteDeliveryByOrderIds(sqlSession, orderIds);
        adminOrderDao.deleteOrderDetailByOrderIds(sqlSession, orderIds);

        return adminOrderDao.deleteOrders(sqlSession, orderIds);
    }

    @Override
    @Transactional
    public int updateDeliveryYn(int orderId, String deliveryYn) {
        Integer deliveryId = adminOrderDao.selectDeliveryIdByOrderId(sqlSession, orderId);

        if (deliveryId == null || deliveryId == 0) {
            adminOrderDao.insertDelivery(sqlSession, orderId);
            deliveryId = adminOrderDao.selectLatestDeliveryIdByOrderId(sqlSession, orderId);
        }

        if (deliveryId == null || deliveryId == 0) {
            return 0;
        }

        HashMap<String, Object> map = new HashMap<>();
        map.put("deliveryId", deliveryId);
        map.put("deliveryYn", deliveryYn);
        map.put("deliveryStatus", "Y".equals(deliveryYn) ? "배송완료" : "배송중");

        Integer statusCount = adminOrderDao.selectStatusCountByDeliveryId(sqlSession, deliveryId);

        if (statusCount != null && statusCount > 0) {
            return adminOrderDao.updateLatestStatus(sqlSession, map);
        } else {
            return adminOrderDao.insertStatus(sqlSession, map);
        }
    }

    @Override
    public AdminOrder selectOrderDetail(int orderId) {
        return adminOrderDao.selectOrderDetail(sqlSession, orderId);
    }

    @Override
    public ArrayList<AdminOrder> selectOrderDetailList(int orderId) {
        return adminOrderDao.selectOrderDetailList(sqlSession, orderId);
    }

    @Override
    @Transactional
    public int updateOrderStatus(int orderId, String orderStatus) {

        String deliveryStatus;
        String deliveryYn;

        if ("PAY".equals(orderStatus)) {
            deliveryStatus = "결제완료";
            deliveryYn = "N";
        } else if ("OUT".equals(orderStatus)) {
            deliveryStatus = "출고완료";
            deliveryYn = "N";
        } else if ("SHIP".equals(orderStatus)) {
            deliveryStatus = "배송중";
            deliveryYn = "N";
        } else if ("DONE".equals(orderStatus)) {
            deliveryStatus = "배송완료";
            deliveryYn = "Y";
        } else {
            return 0;
        }

        Integer deliveryId = adminOrderDao.selectDeliveryIdByOrderId(sqlSession, orderId);

        if (deliveryId == null) {
            int insertDeliveryResult = adminOrderDao.insertDelivery(sqlSession, orderId);
            if (insertDeliveryResult <= 0) {
                return 0;
            }

            deliveryId = adminOrderDao.selectLatestDeliveryIdByOrderId(sqlSession, orderId);
            if (deliveryId == null) {
                return 0;
            }
        }

        Integer statusCount = adminOrderDao.selectStatusCountByDeliveryId(sqlSession, deliveryId);
        if (statusCount == null) {
            statusCount = 0;
        }

        HashMap<String, Object> map = new HashMap<>();
        map.put("deliveryId", deliveryId);
        map.put("deliveryYn", deliveryYn);
        map.put("deliveryStatus", deliveryStatus);

        if (statusCount > 0) {
            return adminOrderDao.updateLatestStatus(sqlSession, map);
        } else {
            return adminOrderDao.insertStatus(sqlSession, map);
        }
    }

    @Override
    @Transactional
    public int updateCancelStatusApproved(int detailId) {
        return adminOrderDao.updateCancelStatusApproved(sqlSession, detailId);
    }

    @Override
    @Transactional
    public int updateCancelStatusRejected(int detailId) {
        return adminOrderDao.updateCancelStatusRejected(sqlSession, detailId);
    }

    @Override
    @Transactional
    public int clearCancelStatus(int detailId) {
        return adminOrderDao.clearCancelStatus(sqlSession, detailId);
    }
}