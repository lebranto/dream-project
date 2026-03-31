package com.kh.jipshop.product.model.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.jipshop.common.model.vo.PageInfo;
import com.kh.jipshop.product.model.vo.ProductSearch;
import com.kh.jipshop.product.model.vo.Products;

@Repository
public class ProductDaoImpl implements ProductDao {

    @Autowired
    private SqlSessionTemplate sqlSession;

    @Override
    public int selectProductListCount(ProductSearch search) {
        return sqlSession.selectOne("productMapper.selectProductListCount", search);
    }

    @Override
    public List<Products> selectProductList(ProductSearch search, PageInfo pi) {

        int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
        RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());

        return sqlSession.selectList("productMapper.selectProductList", search, rowBounds);
    }

    @Override
    public Products selectProductDetail(int productId) {
        return sqlSession.selectOne("productMapper.selectProductDetail", productId);
    }
}