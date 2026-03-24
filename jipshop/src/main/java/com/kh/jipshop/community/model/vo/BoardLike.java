package com.kh.jipshop.community.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class BoardLike {
	 private int boardNo;
	    private int memberNo;
	    private String likeType;

	   

}
