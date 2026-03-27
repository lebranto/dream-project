package com.kh.jipshop.admin.model.service;

import java.util.List;
import java.util.Map;

import com.kh.jipshop.member.model.vo.Member;

public interface AdminMemberService {
	
	int getActiveCount();
    int getBannedCount();
 
    /** 전체 회원 수 (검색 조건 포함) */
    int getMemberCount(Map<String, Object> paramMap);
 
    /** 회원 목록 (페이징 + 검색) */
    List<Member> getMemberList(Map<String, Object> paramMap);


}
