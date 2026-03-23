package com.kh.jipshop.security.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class SecurityDaoImpl implements SecurityDao{
private final SqlSessionTemplate session;
	
	@Override
	public UserDetails loadUserByUserName(String username) {
		return session.selectOne("security.loadUserByUsername", username);
	}
}
