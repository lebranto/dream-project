package com.kh.jipshop.member.model.service;

import com.kh.jipshop.member.model.vo.Member;

public interface MemberService {

	int insertMember(Member m);

	int idCheck(String memberId);

	Member loginMember(Member m);
	
}
