package com.kh.jipshop.product.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.jipshop.common.model.vo.PageInfo;
import com.kh.jipshop.product.model.vo.ProductSearch;
import com.kh.jipshop.product.model.vo.Products;

public interface ProductDao {

    int selectProductListCount(ProductSearch search);

    List<Products> selectProductList(ProductSearch search, PageInfo pi);

    Products selectProductDetail(int productId);
    
    int insertView(Map<String, Object> param);
}