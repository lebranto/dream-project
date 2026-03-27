package com.kh.jipshop.admin.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class AdminOrderCancelSearch {

    private String startDate;
    private String endDate;
    private String cancelStatus;
    private String keyword;
}