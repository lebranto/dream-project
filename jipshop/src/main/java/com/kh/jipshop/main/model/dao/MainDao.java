package com.kh.jipshop.main.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.jipshop.member.model.vo.Pet;
import com.kh.jipshop.product.model.vo.Products;

public interface MainDao {
    List<Products> selectDogRecommend();
    List<Products> selectCatRecommend();
    List<Products> selectDefaultRecommend();
    List<Products> selectPetRecommend(Map<String, String> params);
    List<Products> selectNewProducts();
    List<Products> selectHoneyProducts();
    Pet            selectPetByMemberNo(int memberNo);
}