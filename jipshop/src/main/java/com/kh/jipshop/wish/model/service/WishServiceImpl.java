package com.kh.jipshop.wish.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.jipshop.wish.model.dao.WishDao;
import com.kh.jipshop.wish.model.vo.WishDTO;

@Service
public class WishServiceImpl implements WishService {

    @Autowired
    private WishDao wishDao;

    @Override
    public int insertWish(WishDTO dto) {
        return wishDao.insertWish(dto);
    }

    @Override
    public int deleteWish(int productId, int memberNo) {
        return wishDao.deleteWish(productId, memberNo);
    }

    @Override
    public int deleteAll(int memberNo, List<Integer> ids) {

        int result = 0;

        for(int productId : ids){
            result += wishDao.deleteWish(productId, memberNo);
        }

        return result;
    }

    @Override
    public List<WishDTO> selectWishList(int memberNo) {
        return wishDao.selectWishList(memberNo);
    }

    @Override
    public List<Integer> selectWishIds(int memberNo) {
        return wishDao.selectWishIds(memberNo);
    }

    @Override
    public WishDTO findByUserAndProduct(int memberNo, int productId) {
        return wishDao.findByUserAndProduct(memberNo, productId);
    }
}