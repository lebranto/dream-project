package com.kh.jipshop.review.model.service;

import com.kh.jipshop.review.model.vo.Review;
import com.kh.jipshop.review.model.vo.ReviewableOrderDetail;

public interface ReviewService {

    ReviewableOrderDetail selectWritableDetailByProduct(int memberNo, int productId);

    ReviewableOrderDetail selectWritableDetailByDetailId(int memberNo, int detailId);

    int insertReview(Review review);
}