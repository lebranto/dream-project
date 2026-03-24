package com.kh.jipshop.admin.model.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.jipshop.admin.model.dao.AdminOrderDao;
import com.kh.jipshop.admin.model.vo.AdminOrder;
import com.kh.jipshop.admin.model.vo.AdminOrderSearch;
import com.kh.jipshop.common.model.vo.PageInfo;

@Service
public class AdminOrderServiceImpl implements AdminOrderService {

    @Autowired
    private AdminOrderDao adminOrderDao;

    @Autowired
    private SqlSessionTemplate sqlSession;

    @Override
    public int selectOrderListCount(AdminOrderSearch search) {
        return adminOrderDao.selectOrderListCount(sqlSession, search);
    }

    @Override
    public ArrayList<AdminOrder> selectOrderList(PageInfo pi, AdminOrderSearch search) {
        return adminOrderDao.selectOrderList(sqlSession, pi, search);
    }

    @Override
    public int updateDeliveryYn(int orderId, String deliveryYn) {

        HashMap<String, Object> map = new HashMap<>();
        map.put("orderId", orderId);
        map.put("deliveryYn", deliveryYn);

        return adminOrderDao.updateDeliveryYn(sqlSession, map);
    }

    @Override
    public int deleteOrders(ArrayList<Integer> orderIds) {

        int result1 = adminOrderDao.deleteStatusByOrderIds(sqlSession, orderIds);
        int result2 = adminOrderDao.deleteDeliveryByOrderIds(sqlSession, orderIds);
        int result3 = adminOrderDao.deleteOrderDetailByOrderIds(sqlSession, orderIds);
        int result4 = adminOrderDao.deleteOrdersByOrderIds(sqlSession, orderIds);

        return result4;
    }
}