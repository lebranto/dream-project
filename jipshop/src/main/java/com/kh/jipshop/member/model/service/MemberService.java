package com.kh.jipshop.member.model.service;

import java.util.List;

import com.kh.jipshop.member.model.vo.Member;
import com.kh.jipshop.member.model.vo.Pet;

public interface MemberService {

	int insertMember(Member m);

	int idCheck(String memberId);

	Member loginMember(Member m);

	int insertPet(Pet pet);

	List<String> findMemberId(Member m);

	int findMemberByIdAndPhone(Member m);

	int updateMemberPwd(Member m);
	
}
