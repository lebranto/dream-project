package com.kh.jipshop.member.model.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.jipshop.member.model.dao.MemberDao;
import com.kh.jipshop.member.model.vo.Member;

@Service
public class MemberServiceImpl implements MemberService{
	
	@Autowired
	private MemberDao memberDao;
	
	@Override
	public int insertMember(Member m) {
		return memberDao.insertMember(m);
	}

	@Override
	public int idCheck(String memberId) {
		return memberDao.idCheck(memberId);
	}

	@Override
	public Member loginMember(Member m) {
		return memberDao.loginMember(m);
	}
	
}
