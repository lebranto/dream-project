package com.kh.jipshop.main.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.kh.jipshop.member.model.vo.Pet;
import com.kh.jipshop.product.model.vo.Products;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class MainDaoImpl implements MainDao {

    private final SqlSessionTemplate session;

    @Override
    public List<Products> selectDogRecommend() {
        return session.selectList("main.selectDogRecommend");
    }

    @Override
    public List<Products> selectCatRecommend() {
        return session.selectList("main.selectCatRecommend");
    }

    @Override
    public List<Products> selectDefaultRecommend() {
        return session.selectList("main.selectDefaultRecommend");
    }

    @Override
    public List<Products> selectPetRecommend(Map<String, String> params) {
        return session.selectList("main.selectPetRecommend", params);
    }

    @Override
    public List<Products> selectNewProducts() {
        return session.selectList("main.selectNewProducts");
    }

    @Override
    public List<Products> selectHoneyProducts() {
        return session.selectList("main.selectHoneyProducts");
    }

    @Override
    public Pet selectPetByMemberNo(int memberNo) {
        return session.selectOne("main.selectPetByMemberNo", memberNo);
    }
}