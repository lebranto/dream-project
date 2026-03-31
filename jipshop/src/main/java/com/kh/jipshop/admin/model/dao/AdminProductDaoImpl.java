package com.kh.jipshop.admin.model.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.jipshop.admin.model.vo.AdminProduct;

@Repository
public class AdminProductDaoImpl implements AdminProductDao {

	@Autowired
	private SqlSession session;
	@Override
	public int getProductCount(Map<String, Object> paramMap) {
		return session.selectOne("adminProduct.getProductCount", paramMap);
	}

	@Override
	public List<AdminProduct> getProductList(Map<String, Object> paramMap) {
		return session.selectList("adminProduct.getProductList",paramMap );
	}

	@Override
	public List<Map<String, Object>> getCategoryList() {
		return session.selectList("adminProduct.getCategoryList");
	}

	@Override
	public List<Map<String, Object>> getCompanyList() {
		return session.selectList("adminProduct.getCompanyList");
	}

}
