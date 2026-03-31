package com.kh.jipshop.admin.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.jipshop.admin.model.vo.AdminProduct;

public interface AdminProductDao {

	int getProductCount(Map<String, Object> paramMap);

	List<AdminProduct> getProductList(Map<String, Object> paramMap);

	List<Map<String, Object>> getCategoryList();
	List<Map<String, Object>> getCompanyList();
	
	int insertProduct(AdminProduct product);

	int insertCompany(String name, String phone, String address);

	int selectLastCompanyCode();

}
