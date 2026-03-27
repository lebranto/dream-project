package com.kh.jipshop.admin.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.jipshop.member.model.vo.Member;
import com.kh.jipshop.member.model.vo.Pet;

public interface AdminMemberDao {

	int getActiveCount();

	int getBannedCount();

	int getMemberCount(Map<String, Object> paramMap);

	List<Member> getMemberList(Map<String, Object> paramMap);

	Member getMemberByNo(int memberNo);

	int updateMember(Member member);

	void updateMemberActiveYn(int memberNo);

	List<Pet> getPetListByMemberNo(int memberNo);

}
