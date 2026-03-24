package com.kh.jipshop.community.model.vo;

import java.util.Date;

public class BoardComment {

    private int commentId;
    private int boardNo;
    private int memberNo;
    private String memberId;
    private String commentContent;
    private Date commentRegDate;
    private String commentActiveYn;

    public BoardComment() {
        super();
    }

    public BoardComment(int commentId, int boardNo, int memberNo, String memberId,
                        String commentContent, Date commentRegDate, String commentActiveYn) {
        super();
        this.commentId = commentId;
        this.boardNo = boardNo;
        this.memberNo = memberNo;
        this.memberId = memberId;
        this.commentContent = commentContent;
        this.commentRegDate = commentRegDate;
        this.commentActiveYn = commentActiveYn;
    }

    public int getCommentId() {
        return commentId;
    }

    public void setCommentId(int commentId) {
        this.commentId = commentId;
    }

    public int getBoardNo() {
        return boardNo;
    }

    public void setBoardNo(int boardNo) {
        this.boardNo = boardNo;
    }

    public int getMemberNo() {
        return memberNo;
    }

    public void setMemberNo(int memberNo) {
        this.memberNo = memberNo;
    }

    public String getMemberId() {
        return memberId;
    }

    public void setMemberId(String memberId) {
        this.memberId = memberId;
    }

    public String getCommentContent() {
        return commentContent;
    }

    public void setCommentContent(String commentContent) {
        this.commentContent = commentContent;
    }

    public Date getCommentRegDate() {
        return commentRegDate;
    }

    public void setCommentRegDate(Date commentRegDate) {
        this.commentRegDate = commentRegDate;
    }

    public String getCommentActiveYn() {
        return commentActiveYn;
    }

    public void setCommentActiveYn(String commentActiveYn) {
        this.commentActiveYn = commentActiveYn;
    }

    @Override
    public String toString() {
        return "BoardComment [commentId=" + commentId
                + ", boardNo=" + boardNo
                + ", memberNo=" + memberNo
                + ", memberId=" + memberId
                + ", commentContent=" + commentContent
                + ", commentRegDate=" + commentRegDate
                + ", commentActiveYn=" + commentActiveYn + "]";
    }
}