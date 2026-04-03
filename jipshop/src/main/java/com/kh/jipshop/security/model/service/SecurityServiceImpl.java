package com.kh.jipshop.security.model.service;

import org.springframework.security.authentication.DisabledException;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.kh.jipshop.security.model.dao.SecurityDao;
import com.kh.jipshop.security.model.vo.MemberExt;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class SecurityServiceImpl implements SecurityService{

	/*
	 * 사용자 인증 프로세스
	 * 1. 사용자가 입력한 아이디 값을 기반으로 사용자 정보 조회
	 * 2. 조회된 사용자 정보가 없으면 에러 throw
	 * 3. 인증 성공시 UserDetails객체 반환
	 * 4. 조회된 사용자 정보를 시큐리티의 매니저에게 넘겨 비밀번호 검사 밑 권한 검증에 사용
	 */
	private final SecurityDao dao;
	
	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		UserDetails member = dao.loadUserByUserName(username);
		if(member == null) {
			throw new UsernameNotFoundException(username);
		}
		
		 MemberExt m = (MemberExt) member;

		    if ("N".equals(m.getActiveYn())) {
		        throw new DisabledException("탈퇴한 회원입니다.");
		    }
		
		return member;
	}
	
}

