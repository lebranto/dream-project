package com.kh.jipshop.review.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.jipshop.review.model.dao.ReviewDao;
import com.kh.jipshop.review.model.vo.Review;
import com.kh.jipshop.review.model.vo.ReviewableOrderDetail;

@Service
public class ReviewServiceImpl implements ReviewService {

	@Autowired
    private ReviewDao reviewDao;

    @Override
    public ReviewableOrderDetail selectWritableDetailByProduct(int memberNo, int productId) {
        return reviewDao.selectWritableDetailByProduct(memberNo, productId);
    }

    @Override
    public ReviewableOrderDetail selectWritableDetailByDetailId(int memberNo, int detailId) {
        return reviewDao.selectWritableDetailByDetailId(memberNo, detailId);
    }

    @Override
    public int insertReview(Review review) {
        return reviewDao.insertReview(review);
    }

    @Override
    public List<Review> selectReviewListByProductId(int productId) {
        return reviewDao.selectReviewListByProductId(productId);
    }
}