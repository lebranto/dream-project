package com.kh.jipshop.admin.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.jipshop.admin.model.dao.AdminProductDao;
import com.kh.jipshop.admin.model.vo.AdminProduct;

@Service
public class AdminProductServiceImpl implements AdminProductService {
	
	@Autowired
	private AdminProductDao adminProductDao;
	@Override
	public int getProductCount(Map<String, Object> paramMap) {
		return adminProductDao.getProductCount(paramMap);
	}

	@Override
	public List<AdminProduct> getProductList(Map<String, Object> paramMap) {
		return adminProductDao.getProductList(paramMap);
	}

	@Override
	public List<Map<String, Object>> getCategoryList() {
		return adminProductDao.getCategoryList();
	}

	@Override
	public List<Map<String, Object>> getCompanyList() {
		return adminProductDao.getCompanyList();
	}

	@Override
	public int insertProduct(AdminProduct product) {
		return adminProductDao.insertProduct(product);
	}
	@Override
	public int insertCompany(String name, String phone, String address) {
	    adminProductDao.insertCompany(name, phone, address);
	    return adminProductDao.selectLastCompanyCode();
	}
	@Override
	public int selectLastCompanyCode() {
	    return adminProductDao.selectLastCompanyCode();
	}

}
