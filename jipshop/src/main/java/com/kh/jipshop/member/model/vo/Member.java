package com.kh.jipshop.member.model.vo;

import java.io.Serializable;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Member implements Serializable{
	private static final long serialVersionUID = 1L;
	
	private int memberNo;
    private String memberId;
    private String memberPwd;
    private String memberName;
    private String address;
    private String phone;
    private String email;
    private Date joinDate;
    private String activeYn;
}

