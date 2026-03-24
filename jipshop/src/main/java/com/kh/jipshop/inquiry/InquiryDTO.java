package com.kh.jipshop.inquiry;

public class InquiryDTO {

    private int inquiryNo;
    private String title;
    private String content;
    private String enrollDate;
    private String answerStatus;

    public InquiryDTO() {
    }

    public InquiryDTO(int inquiryNo, String title, String content, String enrollDate, String answerStatus) {
        this.inquiryNo = inquiryNo;
        this.title = title;
        this.content = content;
        this.enrollDate = enrollDate;
        this.answerStatus = answerStatus;
    }

    public int getInquiryNo() {
        return inquiryNo;
    }

    public void setInquiryNo(int inquiryNo) {
        this.inquiryNo = inquiryNo;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getEnrollDate() {
        return enrollDate;
    }

    public void setEnrollDate(String enrollDate) {
        this.enrollDate = enrollDate;
    }

    public String getAnswerStatus() {
        return answerStatus;
    }

    public void setAnswerStatus(String answerStatus) {
        this.answerStatus = answerStatus;
    }
}