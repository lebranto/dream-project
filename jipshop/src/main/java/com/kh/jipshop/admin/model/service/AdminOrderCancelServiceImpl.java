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

        int result1 = adminOrderCancelDao.updateCancelStatusApproved(sqlSession, orderId);
        int result2 = adminOrderCancelDao.restoreProductStock(sqlSession, orderId);

        if(result1 > 0 && result2 >= 0) {
            return 1;
        }

        throw new RuntimeException("취소 승인 처리 실패");
    }

    @Override
    @Transactional
    public int rejectCancel(int orderId) {

        int result = adminOrderCancelDao.updateCancelStatusRejected(sqlSession, orderId);

        if(result > 0) {
            return 1;
        }

        throw new RuntimeException("취소 반려 처리 실패");
    }
}