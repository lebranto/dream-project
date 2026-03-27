package com.kh.jipshop.admin.model.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.jipshop.member.model.vo.Member;

@Repository
public class AdminMemberDaoImpl implements AdminMemberDao{

	@Autowired
    private SqlSessionTemplate session;
 
    private final String am = "adminMember.";
 
    @Override
    public int getActiveCount() {
        return session.selectOne(am + "getActiveCount");
    }
 
    @Override
    public int getBannedCount() {
        return session.selectOne(am + "getBannedCount");
    }
 
    @Override
    public int getMemberCount(Map<String, Object> paramMap) {
        return session.selectOne(am + "getMemberCount", paramMap);
    }
 
    @Override
    public List<Member> getMemberList(Map<String, Object> paramMap) {
        return session.selectList(am + "getMemberList", paramMap);
    }

	@Override
	public Member getMemberByNo(int memberNo) {
		return session.selectOne(am+"getMemberByNo", memberNo);
	}

	@Override
	public int updateMember(Member member) {
		return session.update(am+"updateMember", member);
	}

	@Override
	public void updateMemberActiveYn(int memberNo) {
		session.update(am+"updateMemberActiveYn", memberNo);
		
	}

}
