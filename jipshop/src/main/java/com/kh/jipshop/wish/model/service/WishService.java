package com.kh.jipshop.wish.model.service;

import java.util.List;
import com.kh.jipshop.wish.model.vo.WishDTO;

public interface WishService {

    int insertWish(WishDTO dto);

    int deleteWish(int productId, int memberNo);

    int deleteAll(int memberNo, List<Integer> ids);

    List<WishDTO> selectWishList(int memberNo);

    List<Integer> selectWishIds(int memberNo);

    WishDTO findByUserAndProduct(int memberNo, int productId);
}