package com.kh.jipshop.member.model.vo;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

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
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date petAge;
	private Double petWeight;
	private String petPhoto;
}
