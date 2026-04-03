package com.kh.jipshop.cart.model.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.kh.jipshop.cart.model.dao.CartDao;
import com.kh.jipshop.cart.model.vo.CartDTO;

@Service
public class CartServiceImpl implements CartService {
    @Autowired
    private CartDao cartDao;

    @Override
    public int insertCart(CartDTO dto) { return cartDao.insertCart(dto); }

    @Override
    public List<CartDTO> selectCartList(int memberNo) { return cartDao.selectCartList(memberNo); }

    @Override
    public int updateQty(CartDTO dto) { return cartDao.updateQty(dto); }

    @Override
    public int deleteCart(int cartId) { return cartDao.deleteCart(cartId); }

    @Override
    public int deleteAll(int[] ids) { return cartDao.deleteAll(ids); }

    @Override
    public int selectCount(int memberNo) { return cartDao.selectCount(memberNo); }

    @Override
    public CartDTO findByUserAndProduct(CartDTO dto) { return cartDao.findByUserAndProduct(dto); }
}