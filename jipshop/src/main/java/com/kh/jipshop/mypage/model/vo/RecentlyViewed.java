package com.kh.jipshop.mypage.model.vo;

import java.util.Date;

import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class RecentlyViewed {

	private int viewId;
	private int memberNO;
	private int productId;
	private Date viewedDate;

}
