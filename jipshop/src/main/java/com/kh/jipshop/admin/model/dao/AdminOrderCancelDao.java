package com.kh.jipshop.admin.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;

import com.kh.jipshop.admin.model.vo.AdminOrderCancel;
import com.kh.jipshop.admin.model.vo.AdminOrderSearch;
import com.kh.jipshop.common.model.vo.PageInfo;

public interface AdminOrderCancelDao {

    int selectOrderCancelListCount(SqlSessionTemplate sqlSession, AdminOrderSearch search);

    ArrayList<AdminOrderCancel> selectOrderCancelList(SqlSessionTemplate sqlSession, PageInfo pi, AdminOrderSearch search);

    int approveOrderCancel(SqlSessionTemplate sqlSession, ArrayList<Integer> orderIdList);

    int rejectOrderCancel(SqlSessionTemplate sqlSession, ArrayList<Integer> orderIdList);

    int deleteStatusByOrderIds(SqlSessionTemplate sqlSession, ArrayList<Integer> orderIdList);

    int deleteDeliveryByOrderIds(SqlSessionTemplate sqlSession, ArrayList<Integer> orderIdList);

    int deleteOrderDetailByOrderIds(SqlSessionTemplate sqlSession, ArrayList<Integer> orderIdList);

    int deleteOrdersByOrderIds(SqlSessionTemplate sqlSession, ArrayList<Integer> orderIdList);
}