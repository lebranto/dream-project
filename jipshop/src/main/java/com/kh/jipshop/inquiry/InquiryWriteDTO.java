package com.kh.jipshop.inquiry;

public class InquiryWriteDTO {

    private String category;
    private String content;
    private String password;

    public InquiryWriteDTO() {
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }
}