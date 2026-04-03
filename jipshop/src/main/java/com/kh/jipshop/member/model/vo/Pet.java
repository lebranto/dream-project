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
	
	
	// 연령대 계산 메서드 추가
	public String getAgeGroup() {
	    if (petAge == null) return null;
	    long diffMs    = new Date().getTime() - petAge.getTime();
	    long diffYears = diffMs / (1000L * 60 * 60 * 24 * 365);
	    if (diffYears < 1)  return "키드";
	    if (diffYears <= 7) return "어덜트";
	    return "시니어";
	}
}
