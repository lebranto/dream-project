package com.kh.jipshop.member.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.jipshop.member.model.dao.MemberDao;
import com.kh.jipshop.member.model.vo.Member;
import com.kh.jipshop.member.model.vo.Pet;

@Service
public class MemberServiceImpl implements MemberService{
	
	@Autowired
	private MemberDao memberDao;
	
	@Override
	public int insertMember(Member m) {
		int result = memberDao.insertMember(m);
		memberDao.insertAuthority(m);
		return result;
	}

	@Override
	public int idCheck(String memberId) {
		return memberDao.idCheck(memberId);
	}

	@Override
	public Member loginMember(Member m) {
		return memberDao.loginMember(m);
	}

	@Override
	public int insertPet(Pet pet) {
		return memberDao.insertPet(pet);
	}

	@Override
	public List<String> findMemberId(Member m) {
		return memberDao.findMemberId(m);
	}



	
	
}
