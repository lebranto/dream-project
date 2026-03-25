package com.kh.jipshop.admin.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.jipshop.admin.model.dao.AdminOrderCancelDao;
import com.kh.jipshop.admin.model.vo.AdminOrderCancel;
import com.kh.jipshop.admin.model.vo.AdminOrderSearch;
import com.kh.jipshop.common.model.vo.PageInfo;

@Service
public class AdminOrderCancelServiceImpl implements AdminOrderCancelService {

    @Autowired
    private AdminOrderCancelDao adminOrderCancelDao;

    @Autowired
    private SqlSessionTemplate sqlSession;

    @Override
    public int selectOrderCancelListCount(AdminOrderSearch search) {
        return adminOrderCancelDao.selectOrderCancelListCount(sqlSession, search);
    }

    @Override
    public ArrayList<AdminOrderCancel> selectOrderCancelList(PageInfo pi, AdminOrderSearch search) {
        return adminOrderCancelDao.selectOrderCancelList(sqlSession, pi, search);
    }

    @Override
    public int approveOrderCancel(String orderIds) {
        return adminOrderCancelDao.approveOrderCancel(sqlSession, parseIds(orderIds));
    }

    @Override
    public int rejectOrderCancel(String orderIds) {
        return adminOrderCancelDao.rejectOrderCancel(sqlSession, parseIds(orderIds));
    }

    @Override
    public int deleteOrderCancel(String orderIds) {

        ArrayList<Integer> orderIdList = parseIds(orderIds);

        adminOrderCancelDao.deleteStatusByOrderIds(sqlSession, orderIdList);
        adminOrderCancelDao.deleteDeliveryByOrderIds(sqlSession, orderIdList);
        adminOrderCancelDao.deleteOrderDetailByOrderIds(sqlSession, orderIdList);

        return adminOrderCancelDao.deleteOrdersByOrderIds(sqlSession, orderIdList);
    }

    private ArrayList<Integer> parseIds(String orderIds) {

        ArrayList<Integer> list = new ArrayList<>();

        String[] arr = orderIds.split(",");

        for(String s : arr) {
            list.add(Integer.parseInt(s.trim()));
        }

        return list;
    }
}