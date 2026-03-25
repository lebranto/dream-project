package com.kh.jipshop.member.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.jipshop.member.model.vo.Member;
import com.kh.jipshop.member.model.vo.Pet;

@Repository
public class MemberDaoImpl implements MemberDao{
	
	@Autowired
	private SqlSessionTemplate session;
	
	@Override
	public int insertMember(Member m) {
		return session.insert("member.insertMember", m);
	}

	@Override
	public int idCheck(String memberId) {
		return session.selectOne("member.idCheck", memberId);
	}

	@Override
	public Member loginMember(Member m) {
		return session.selectOne("member.loginMember", m);
	}

	@Override
	public void insertAuthority(Member m) {
		session.insert("member.insertAuthority", m);
		
	}

	@Override
	public int insertPet(Pet pet) {
		return session.insert("member.insertPet",pet);
	}


}
