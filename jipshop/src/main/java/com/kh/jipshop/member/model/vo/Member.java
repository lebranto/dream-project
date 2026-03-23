package com.kh.jipshop.member.model.vo;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class Member {
	private int memberNo;
    private String memberId;
    private String memberPwd;
    private String memberName;
    private String address;
    private String phone;
    private String email;
    private Date joinDate;
    private String action;
}

