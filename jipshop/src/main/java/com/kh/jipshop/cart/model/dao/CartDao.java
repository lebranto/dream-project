package com.kh.jipshop.cart.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.jipshop.cart.model.vo.CartDTO;

public interface CartDao {

    int insertCart(CartDTO dto);

    List<CartDTO> selectCartList(int userId);

    int updateQty(CartDTO dto);

    int deleteCart(int cartId);

    int deleteAll(int[] ids);

    int selectCount(int userId);

    CartDTO findByUserAndProduct(CartDTO dto);

	List<CartDTO> selectCartItemsByIds(Map<String, Object> param);
}