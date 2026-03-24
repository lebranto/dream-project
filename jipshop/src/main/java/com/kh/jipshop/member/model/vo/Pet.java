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
public class Pet {
	private int petNo;
	private int memberNo;
	private String petType;
	private String petName;
	private Date petAge;
	private double petWeight;
	private String petPhoto;
}
