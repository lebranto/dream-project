package com.kh.jipshop.review.model.dao;

import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.jipshop.review.model.vo.Review;
import com.kh.jipshop.review.model.vo.ReviewableOrderDetail;

@Repository
public class ReviewDaoImpl implements ReviewDao {

    @Autowired
    private SqlSessionTemplate sqlSession;

    @Override
    public ReviewableOrderDetail selectWritableDetailByProduct(int memberNo, int productId) {
        Map<String, Object> param = new HashMap<>();
        param.put("memberNo", memberNo);
        param.put("productId", productId);

        return sqlSession.selectOne("reviewMapper.selectWritableDetailByProduct", param);
    }

    @Override
    public ReviewableOrderDetail selectWritableDetailByDetailId(int memberNo, int detailId) {
        Map<String, Object> param = new HashMap<>();
        param.put("memberNo", memberNo);
        param.put("detailId", detailId);

        return sqlSession.selectOne("reviewMapper.selectWritableDetailByDetailId", param);
    }

    @Override
    public int insertReview(Review review) {
        return sqlSession.insert("reviewMapper.insertReview", review);
    }
}