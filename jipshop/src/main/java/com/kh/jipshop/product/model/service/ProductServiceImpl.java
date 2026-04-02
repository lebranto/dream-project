package com.kh.jipshop.product.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.jipshop.common.model.vo.PageInfo;
import com.kh.jipshop.product.model.dao.ProductDao;
import com.kh.jipshop.product.model.vo.ProductSearch;
import com.kh.jipshop.product.model.vo.Products;

@Service
public class ProductServiceImpl implements ProductService {

    @Autowired
    private ProductDao productDao;

    @Override
    public Products selectProductDetail(int productId) {
        return productDao.selectProductDetail(productId);
    }
    

    @Override
    public List<Products> selectProductList(ProductSearch search, PageInfo pi) {
        return productDao.selectProductList(search, pi);
    }

    @Override
    public int selectProductListCount(ProductSearch search) {
        return productDao.selectProductListCount(search);
    }
}