package com.kh.jipshop.wish.model.dao;

import java.util.List;

import com.kh.jipshop.wish.model.vo.WishDTO;

public interface WishDao {

    int insertWish(WishDTO dto);

    int deleteWish(int productId, int memberNo);

    int deleteAll(int memberNo, int[] ids);

    List<WishDTO> selectWishList(int memberNo);

    List<Integer> selectWishIds(int memberNo);

    WishDTO findByUserAndProduct(int memberNo, int productId);
}