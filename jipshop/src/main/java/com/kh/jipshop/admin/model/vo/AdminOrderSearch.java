package com.kh.jipshop.admin.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class AdminOrderSearch {

    private String startDate;   // YYYY-MM-DD
    private String endDate;     // YYYY-MM-DD

    private String keyword;

}