package com.kh.jipshop.admin.model.service;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.kh.jipshop.admin.model.dao.AdminOrderCancelDao;
import com.kh.jipshop.admin.model.vo.AdminOrderCancel;
import com.kh.jipshop.admin.model.vo.AdminOrderCancelSearch;
import com.kh.jipshop.common.model.vo.PageInfo;

@Service
public class AdminOrderCancelServiceImpl implements AdminOrderCancelService {

    @Autowired
    private SqlSessionTemplate sqlSession;

    @Autowired
    private AdminOrderCancelDao adminOrderCancelDao;

    @Override
    public int selectOrderCancelListCount(AdminOrderCancelSearch search) {
        return adminOrderCancelDao.selectOrderCancelListCount(sqlSession, search);
    }

    @Override
    public ArrayList<AdminOrderCancel> selectOrderCancelList(PageInfo pi, AdminOrderCancelSearch search) {
        return adminOrderCancelDao.selectOrderCancelList(sqlSession, pi, search);
    }

    @Override
    public int selectPendingCancelCount() {
        return adminOrderCancelDao.selectPendingCancelCount(sqlSession);
    }

    @Override
    @Transactional
    public int approveCancel(int orderId) {
        return adminOrderCancelDao.updateCancelStatusApproved(sqlSession, orderId);
    }

    @Override
    @Transactional
    public int rejectCancel(int orderId) {
        return adminOrderCancelDao.updateCancelStatusRejected(sqlSession, orderId);
    }
}