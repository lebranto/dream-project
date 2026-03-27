package com.kh.jipshop.admin.model.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.jipshop.admin.model.dao.AdminMemberDao;
import com.kh.jipshop.member.model.vo.Member;
import com.kh.jipshop.member.model.vo.Pet;

@Service
public class AdminMemberServiceImpl implements AdminMemberService{
	@Autowired
	private AdminMemberDao adminMemberDao;
	
	@Override
    public int getActiveCount() {
        return adminMemberDao.getActiveCount();
    }
 
    @Override
    public int getBannedCount() {
        return adminMemberDao.getBannedCount();
    }
 
    @Override
    public int getMemberCount(Map<String, Object> paramMap) {
        return adminMemberDao.getMemberCount(paramMap);
    }
 
    @Override
    public List<Member> getMemberList(Map<String, Object> paramMap) {
        return adminMemberDao.getMemberList(paramMap);
    }

	@Override
	public Member getMemberByNo(int memberNo) {
		return adminMemberDao.getMemberByNo(memberNo);
	}

	@Override
	public int updateMember(Member member) {
		return adminMemberDao.updateMember(member);
	}

	@Override
	public void updateMemberActiveYn(int memberNo) {
		adminMemberDao.updateMemberActiveYn(memberNo);
		
	}

	@Override
	public List<Pet> getPetListByMemberNo(int memberNo) {
		return adminMemberDao.getPetListByMemberNo(memberNo);
	}

	
}
