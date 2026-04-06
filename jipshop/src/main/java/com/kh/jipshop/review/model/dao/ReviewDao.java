package com.kh.jipshop.review.model.dao;

import java.util.List;

import com.kh.jipshop.review.model.vo.Review;
import com.kh.jipshop.review.model.vo.ReviewableOrderDetail;

public interface ReviewDao {

    ReviewableOrderDetail selectWritableDetailByProduct(int memberNo, int productId);

    ReviewableOrderDetail selectWritableDetailByDetailId(int memberNo, int detailId);

    int insertReview(Review review);
    
    List<Review> selectReviewListByProductId(int productId);
}