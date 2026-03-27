package com.kh.jipshop.admin.model.dao;

import java.util.List;
import java.util.Map;

import com.kh.jipshop.member.model.vo.Member;

public interface AdminMemberDao {

	int getActiveCount();

	int getBannedCount();

	int getMemberCount(Map<String, Object> paramMap);

	List<Member> getMemberList(Map<String, Object> paramMap);

}
