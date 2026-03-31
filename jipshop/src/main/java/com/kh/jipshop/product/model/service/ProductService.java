package com.kh.jipshop.product.model.service;

import java.util.List;

import com.kh.jipshop.common.model.vo.PageInfo;
import com.kh.jipshop.product.model.vo.ProductSearch;
import com.kh.jipshop.product.model.vo.Products;

public interface ProductService {

    int selectProductListCount(ProductSearch search);

    List<Products> selectProductList(ProductSearch search, PageInfo pi);

    Products selectProductDetail(int productId);
}