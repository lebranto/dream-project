package com.kh.jipshop.community.model.vo;

public class BoardLike {
	 private int boardNo;
	    private int memberNo;
	    private String likeType;

	    public BoardLike() {}

	    public BoardLike(int boardNo, int memberNo, String likeType) {
	        this.boardNo = boardNo;
	        this.memberNo = memberNo;
	        this.likeType = likeType;
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

		public String getLikeType() {
			return likeType;
		}

		public void setLikeType(String likeType) {
			this.likeType = likeType;
		}
	    

}
