package com.kh.jipshop.member.model.dao;

import com.kh.jipshop.member.model.vo.Member;

public interface MemberDao {

	int insertMember(Member m);

	int idCheck(String memberId);

	Member loginMember(Member m);

}
