package com.kh.jipshop.admin.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;

import com.kh.jipshop.admin.model.vo.AdminOrder;
import com.kh.jipshop.admin.model.vo.AdminOrderSearch;
import com.kh.jipshop.common.model.vo.PageInfo;

public interface AdminOrderDao {

	int selectOrderListCount(SqlSessionTemplate sqlSession, AdminOrderSearch search);

	ArrayList<AdminOrder> selectOrderList(SqlSessionTemplate sqlSession, PageInfo pi, AdminOrderSearch search);

	int updateDeliveryYn(SqlSessionTemplate sqlSession, HashMap<String, Object> map);

	int deleteStatusByOrderIds(SqlSessionTemplate sqlSession, ArrayList<Integer> orderIds);

	int deleteDeliveryByOrderIds(SqlSessionTemplate sqlSession, ArrayList<Integer> orderIds);

	int deleteOrderDetailByOrderIds(SqlSessionTemplate sqlSession, ArrayList<Integer> orderIds);

	int deleteOrdersByOrderIds(SqlSessionTemplate sqlSession, ArrayList<Integer> orderIds);

}
