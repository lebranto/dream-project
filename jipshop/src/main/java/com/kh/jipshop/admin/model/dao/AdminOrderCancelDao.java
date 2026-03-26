package com.kh.jipshop.admin.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;

import com.kh.jipshop.admin.model.vo.AdminOrderCancel;
import com.kh.jipshop.admin.model.vo.AdminOrderCancelSearch;
import com.kh.jipshop.admin.model.vo.AdminOrderSearch;
import com.kh.jipshop.common.model.vo.PageInfo;

public interface AdminOrderCancelDao {

	int selectOrderCancelListCount(SqlSessionTemplate sqlSession, AdminOrderCancelSearch search);

	ArrayList<AdminOrderCancel> selectOrderCancelList(SqlSessionTemplate sqlSession, PageInfo pi,
			AdminOrderCancelSearch search);

	int selectPendingCancelCount(SqlSessionTemplate sqlSession);

	int updateCancelStatusApproved(SqlSessionTemplate sqlSession, int orderId);

	int restoreProductStock(SqlSessionTemplate sqlSession, int orderId);

	int updateCancelStatusRejected(SqlSessionTemplate sqlSession, int orderId);

  
}