package com.kh.jipshop.admin.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.jipshop.admin.model.vo.AdminProduct;

@Repository
public class AdminProductDaoImpl implements AdminProductDao {

	@Autowired
	private SqlSession session;
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
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

	@Override
	public int insertProduct(AdminProduct product) {
		return session.insert("adminProduct.insertProduct", product);
	}
	@Override
	public int insertCompany(String name, String phone, String address) {
	    Map<String, Object> map = new HashMap<>();
	    map.put("name", name);
	    map.put("phone", phone);
	    map.put("address", address);
	    return session.insert("adminProduct.insertCompany", map);
	}

	@Override
	public int selectLastCompanyCode() {
	    return session.selectOne("adminProduct.selectLastCompanyCode");
	}
	@Override
	public AdminProduct selectProductDetail(SqlSessionTemplate sqlSession, int productId) {
	    return sqlSession.selectOne("adminProduct.selectProductDetail", productId);
	}

	@Override
	public int updateProduct(SqlSessionTemplate sqlSession, AdminProduct product) {
	    return sqlSession.update("adminProduct.updateProduct", product);
	}

	@Override
	public int updateProductActiveYn(SqlSessionTemplate sqlSession, AdminProduct product) {
	    return sqlSession.update("adminProduct.updateProductActiveYn", product);
	}
	

}
