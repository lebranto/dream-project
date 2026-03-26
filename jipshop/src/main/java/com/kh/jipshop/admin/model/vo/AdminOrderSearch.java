package com.kh.jipshop.admin.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class AdminOrderSearch {

	private String startYear;
    private String startMonth;
    private String startDay;

    private String endYear;
    private String endMonth;
    private String endDay;

    private String keyword;

 
}