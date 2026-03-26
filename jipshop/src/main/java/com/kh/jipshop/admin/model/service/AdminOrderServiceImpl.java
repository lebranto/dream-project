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

        if (deliveryId == null) {
            adminOrderDao.insertDelivery(sqlSession, orderId);
            deliveryId = adminOrderDao.selectLatestDeliveryIdByOrderId(sqlSession, orderId);
        }

        if (deliveryId == null) {
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
}