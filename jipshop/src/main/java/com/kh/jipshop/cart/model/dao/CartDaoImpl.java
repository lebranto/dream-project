package com.kh.jipshop.cart.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.jipshop.cart.model.vo.CartDTO;

@Repository
public class CartDaoImpl implements CartDao {

    @Autowired
    private SqlSessionTemplate sqlSession;

    // ⭐ mapper namespace
    private final String namespace = "cartMapper.";

    // ===============================
    // ✅ 장바구니 추가
    // ===============================
    @Override
    public int insertCart(CartDTO dto) {
        return sqlSession.insert(namespace + "insertCart", dto);
    }

    // ===============================
    // ✅ 장바구니 리스트
    // ===============================
    @Override
    public List<CartDTO> selectCartList(int userId) {
        return sqlSession.selectList(namespace + "selectCartList", userId);
    }

    // ===============================
    // ✅ 수량 변경
    // ===============================
    @Override
    public int updateQty(CartDTO dto) {
        return sqlSession.update(namespace + "updateQty", dto);
    }

    // ===============================
    // ✅ 개별 삭제
    // ===============================
    @Override
    public int deleteCart(int cartId) {
        return sqlSession.delete(namespace + "deleteCart", cartId);
    }

    // ===============================
    // ✅ 선택 삭제
    // ===============================
    @Override
    public int deleteAll(int[] ids) {
        return sqlSession.delete(namespace + "deleteAll", ids);
    }

    // ===============================
    // ✅ 장바구니 개수
    // ===============================
    @Override
    public int selectCount(int userId) {
        return sqlSession.selectOne(namespace + "selectCount", userId);
    }

    // ===============================
    // ✅ 중복 체크
    // ===============================
    @Override
    public CartDTO findByUserAndProduct(CartDTO dto) {
        return sqlSession.selectOne(namespace + "findByUserAndProduct", dto);
    }

	@Override
	public List<CartDTO> selectCartItemsByIds(Map<String, Object> param) {
		return sqlSession.selectList("cartMapper.selectCartItemsByIds", param);
	}
}