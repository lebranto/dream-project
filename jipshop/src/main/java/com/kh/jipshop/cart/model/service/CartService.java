package com.kh.jipshop.cart.model.service;

import java.util.List;
import com.kh.jipshop.cart.model.vo.CartDTO;

public interface CartService {
    int insertCart(CartDTO dto);
    List<CartDTO> selectCartList(int memberNo);
    int updateQty(CartDTO dto);
    int deleteCart(int cartId);
    int deleteAll(int[] ids);
    int selectCount(int memberNo);
    CartDTO findByUserAndProduct(CartDTO dto);
}