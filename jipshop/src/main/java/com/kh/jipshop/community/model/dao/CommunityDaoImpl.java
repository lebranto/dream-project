package com.kh.jipshop.community.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.jipshop.community.model.vo.Board;
import com.kh.jipshop.community.model.vo.BoardComment;
import com.kh.jipshop.community.model.vo.BoardImage;
import com.kh.jipshop.community.model.vo.BoardLike;

@Repository
	public class CommunityDaoImpl implements CommunityDao {

	    @Autowired
	    private SqlSessionTemplate sqlSession;

	    @Override
	    public Board selectBoard(int boardNo) {
	        return sqlSession.selectOne("communityMapper.selectBoard", boardNo);
	    }

	    @Override
	    public List<BoardImage> selectBoardImageList(int boardNo) {
	        return sqlSession.selectList("communityMapper.selectBoardImageList", boardNo);
	    }

	    @Override
	    public List<BoardComment> selectCommentList(int boardNo) {
	        return sqlSession.selectList("communityMapper.selectCommentList", boardNo);
	    }

		@Override
		public int insertBoard(SqlSessionTemplate sqlSession, Board board) {
			  return sqlSession.insert("communityMapper.insertBoard", board);
		}
		@Override
	    public List<Board> selectPopularBoardList(SqlSessionTemplate sqlSession, Map<String, String> paramMap) {
	        return sqlSession.selectList("communityMapper.selectPopularBoardList", paramMap);
	    }

	    @Override
	    public List<Board> selectLatestBoardList(SqlSessionTemplate sqlSession, Map<String, String> paramMap) {
	        return sqlSession.selectList("communityMapper.selectLatestBoardList", paramMap);
	    }

		@Override
		public List<Board> selectBoardListByBoardCode(int boardCode) {
		    return sqlSession.selectList("communityMapper.selectBoardListByBoardCode", boardCode);
		}
		 @Override
		    public int updateBoard(SqlSessionTemplate sqlSession, Board board) {
		        return sqlSession.update("communityMapper.updateBoard", board);
		    }

		    @Override
		    public int deleteBoardImageList(SqlSessionTemplate sqlSession, List<Integer> deleteImageNos) {
		        return sqlSession.delete("communityMapper.deleteBoardImageList", deleteImageNos);
		    }

		    @Override
		    public int insertBoardImage(SqlSessionTemplate sqlSession, BoardImage boardImage) {
		        return sqlSession.insert("communityMapper.insertBoardImage", boardImage);
		    }

		    @Override
		    public int selectBoardImageCount(SqlSessionTemplate sqlSession, int boardNo) {
		        return sqlSession.selectOne("communityMapper.selectBoardImageCount", boardNo);
		    }

		    @Override
		    public int increaseReadCount(SqlSessionTemplate sqlSession, int boardNo) {
		        return sqlSession.update("communityMapper.increaseReadCount", boardNo);
		    }

		    @Override
		    public int checkBoardLike(SqlSessionTemplate sqlSession, BoardLike boardLike) {
		        return sqlSession.selectOne("communityMapper.checkBoardLike", boardLike);
		    }

		    @Override
		    public int insertBoardLike(SqlSessionTemplate sqlSession, BoardLike boardLike) {
		        return sqlSession.insert("communityMapper.insertBoardLike", boardLike);
		    }

		    @Override
		    public int deleteBoardLike(SqlSessionTemplate sqlSession, BoardLike boardLike) {
		        return sqlSession.delete("communityMapper.deleteBoardLike", boardLike);
		    }

		    @Override
		    public int selectLikeCount(SqlSessionTemplate sqlSession, int boardNo) {
		        return sqlSession.selectOne("communityMapper.selectLikeCount", boardNo);
		    }

		    @Override
		    public List<Board> selectBoardListBySearch(SqlSessionTemplate sqlSession, Map<String, Object> paramMap) {
		        return sqlSession.selectList("communityMapper.selectBoardListBySearch", paramMap);
		    }
		    @Override
		    public int deleteBoard(SqlSessionTemplate sqlSession, Board board) {
		        return sqlSession.update("communityMapper.deleteBoard", board);
		    }
		    @Override
		    public int insertComment(SqlSessionTemplate sqlSession, BoardComment comment) {
		        return sqlSession.insert("communityMapper.insertComment", comment);
		    }
		    @Override
		    public int insertCommentReport(SqlSessionTemplate sqlSession, int reporterMemberNo, int commentId) {
		        Map<String, Integer> param = new HashMap<>();
		        param.put("reporterMemberNo", reporterMemberNo);
		        param.put("commentId", commentId);

		        return sqlSession.insert("communityMapper.insertCommentReport", param);
		    }
}
