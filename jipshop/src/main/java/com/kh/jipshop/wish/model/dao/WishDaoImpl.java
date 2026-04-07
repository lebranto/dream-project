package com.kh.jipshop.wish.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.jipshop.wish.model.vo.WishDTO;

@Repository
public class WishDaoImpl implements WishDao {

    @Autowired
    private SqlSessionTemplate sqlSession;

    @Override
    public int insertWish(WishDTO dto) {
        return sqlSession.insert("wish.insertWish", dto);
    }

    @Override
    public int deleteWish(int productId, int memberNo) {
        Map<String, Object> map = new HashMap<>();
        map.put("productId", productId);
        map.put("memberNo", memberNo);

        return sqlSession.delete("wish.deleteWish", map);
    }

    @Override
    public int deleteAll(int memberNo, int[] ids) {
        Map<String, Object> map = new HashMap<>();
        map.put("memberNo", memberNo);
        map.put("ids", ids);

        return sqlSession.delete("wish.deleteAll", map);
    }

    @Override
    public List<WishDTO> selectWishList(int memberNo) {
        return sqlSession.selectList("wish.selectWishList", memberNo);
    }

    @Override
    public List<Integer> selectWishIds(int memberNo) {
        return sqlSession.selectList("wish.selectWishIds", memberNo);
    }

    @Override
    public WishDTO findByUserAndProduct(int memberNo, int productId) {
        Map<String, Object> map = new HashMap<>();
        map.put("memberNo", memberNo);
        map.put("productId", productId);

        return sqlSession.selectOne("wish.findByUserAndProduct", map);
    }
}