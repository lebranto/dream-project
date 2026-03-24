package com.kh.jipshop.member.model.service;

import com.kh.jipshop.member.model.vo.Member;
import com.kh.jipshop.member.model.vo.Pet;

public interface MemberService {

	int insertMember(Member m);

	int idCheck(String memberId);

	Member loginMember(Member m);

	int insertPet(Pet pet);
	
}
