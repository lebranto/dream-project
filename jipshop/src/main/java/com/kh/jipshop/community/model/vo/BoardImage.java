package com.kh.jipshop.community.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class BoardImage {

    private int imgNo;
    private int boardNo;
    private String originName;
    private String changeName;
    private String filePath;
    private int fileLevel;
    private Date uploadDate;

   
}