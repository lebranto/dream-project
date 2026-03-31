package com.kh.jipshop.admin.model.service;

import java.util.List;
import java.util.Map;

import com.kh.jipshop.admin.model.vo.AdminProduct;

public interface AdminProductService {

	int getProductCount(Map<String, Object> paramMap);

	List<AdminProduct> getProductList(Map<String, Object> paramMap);

	List<Map<String, Object>> getCategoryList();
	List<Map<String, Object>> getCompanyList();

	int insertProduct(AdminProduct product);

	

}
