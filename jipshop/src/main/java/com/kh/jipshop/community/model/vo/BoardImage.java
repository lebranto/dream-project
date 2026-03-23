package com.kh.jipshop.community.model.vo;

import java.sql.Date;

public class BoardImage {

    private int imgNo;
    private int boardNo;
    private String originName;
    private String changeName;
    private String filePath;
    private int fileLevel;
    private Date uploadDate;

    public BoardImage() {}

    public BoardImage(int imgNo, int boardNo, String originName, String changeName, String filePath, int fileLevel,
            Date uploadDate) {
        this.imgNo = imgNo;
        this.boardNo = boardNo;
        this.originName = originName;
        this.changeName = changeName;
        this.filePath = filePath;
        this.fileLevel = fileLevel;
        this.uploadDate = uploadDate;
    }

    public int getImgNo() {
        return imgNo;
    }

    public void setImgNo(int imgNo) {
        this.imgNo = imgNo;
    }

    public int getBoardNo() {
        return boardNo;
    }

    public void setBoardNo(int boardNo) {
        this.boardNo = boardNo;
    }

    public String getOriginName() {
        return originName;
    }

    public void setOriginName(String originName) {
        this.originName = originName;
    }

    public String getChangeName() {
        return changeName;
    }

    public void setChangeName(String changeName) {
        this.changeName = changeName;
    }

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    public int getFileLevel() {
        return fileLevel;
    }

    public void setFileLevel(int fileLevel) {
        this.fileLevel = fileLevel;
    }

    public Date getUploadDate() {
        return uploadDate;
    }

    public void setUploadDate(Date uploadDate) {
        this.uploadDate = uploadDate;
    }

    @Override
    public String toString() {
        return "BoardImage [imgNo=" + imgNo + ", boardNo=" + boardNo + ", originName=" + originName + ", changeName="
                + changeName + ", filePath=" + filePath + ", fileLevel=" + fileLevel + ", uploadDate=" + uploadDate
                + "]";
    }
}