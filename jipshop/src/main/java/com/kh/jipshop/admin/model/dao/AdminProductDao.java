package com.kh.jipshop.admin.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;

import com.kh.jipshop.admin.model.vo.AdminProduct;

public interface AdminProductDao {

	int getProductCount(Map<String, Object> paramMap);

	List<AdminProduct> getProductList(Map<String, Object> paramMap);

	List<Map<String, Object>> getCategoryList();
	List<Map<String, Object>> getCompanyList();
	
	int insertProduct(AdminProduct product);

	int insertCompany(String name, String phone, String address);

	int selectLastCompanyCode();

	AdminProduct selectProductDetail(SqlSessionTemplate sqlSession, int productId);

	int updateProduct(SqlSessionTemplate sqlSession, AdminProduct product);

	int updateProductActiveYn(SqlSessionTemplate sqlSession, AdminProduct product);

}
