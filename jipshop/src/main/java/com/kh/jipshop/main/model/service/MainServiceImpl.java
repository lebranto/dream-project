package com.kh.jipshop.main.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.kh.jipshop.main.model.dao.MainDao;
import com.kh.jipshop.member.model.vo.Pet;
import com.kh.jipshop.product.model.vo.Products;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MainServiceImpl implements MainService {

    private final MainDao mainDao;

    @Override
    public List<Products> selectDogRecommend() {
        return mainDao.selectDogRecommend();
    }

    @Override
    public List<Products> selectCatRecommend() {
        return mainDao.selectCatRecommend();
    }

    @Override
    public List<Products> selectDefaultRecommend() {
        return mainDao.selectDefaultRecommend();
    }

    @Override
    public List<Products> selectPetRecommend(Map<String, String> params) {
        return mainDao.selectPetRecommend(params);
    }

    @Override
    public List<Products> selectNewProducts() {
        return mainDao.selectNewProducts();
    }

    @Override
    public List<Products> selectHoneyProducts() {
        return mainDao.selectHoneyProducts();
    }

    @Override
    public Pet selectPetByMemberNo(int memberNo) {
        return mainDao.selectPetByMemberNo(memberNo);
    }
}