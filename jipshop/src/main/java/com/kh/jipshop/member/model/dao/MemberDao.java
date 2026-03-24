package com.kh.jipshop.member.model.dao;

import com.kh.jipshop.member.model.vo.Member;
import com.kh.jipshop.member.model.vo.Pet;

public interface MemberDao {

	int insertMember(Member m);

	int idCheck(String memberId);

	Member loginMember(Member m);

	void insertAuthority(Member m);

	int insertPet(Pet pet);



}
