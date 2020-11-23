package com.moonboard.service;

import java.util.List;

import com.moonboard.domain.BoardVO;
import com.moonboard.domain.Board_categoryVO;
import com.moonboard.domain.Board_pageVO;
import com.moonboard.domain.Board_replyVO;
import com.moonboard.domain.Board_simple_pageVO;
import com.moonboard.domain.Criteria;
import com.moonboard.domain.ImageVO;

public interface BoardService {
	// 게시판정보를 read
	public BoardVO read(int no);
	// 게시판의 카테고리를 read
	public List<Board_categoryVO> readCategory(int no);
	public String getCategoryName(int cno);
	public int write(Board_pageVO bpVo);
	public Board_pageVO readPage(int pno);
	public List<Board_simple_pageVO> getListWithPaging(Criteria cri);
	public int getTotalCount(int cno);
	public int registeReply(Board_replyVO vo);
	public List<Board_replyVO> getReplyList(int pno);
	public int registeReply_rereply(Board_replyVO vo);
	public int checkManager(String manager_userid);
	public void makeBoard(BoardVO bVo);
	public List<BoardVO> getTopBoard();
	public String getBoardManagerID(int no);
	
	public List<ImageVO> findPageImg(int pno);
	public int changeTitle(BoardVO bVo);
	public int changeSubTitle(BoardVO bVo);
	public int makeMotherCategory(Board_categoryVO cVo);
	public int makeSonCategory(Board_categoryVO cVo);
	public int inputBanner(ImageVO iVo);
	public ImageVO readMainBanner(int no);
	public ImageVO readTopBanner(int no);
	public List<BoardVO> getSearchBoard(String title);
	public List<Board_simple_pageVO> findNotice(int no);
	public int findNoticeNo(int no);
	public List<Board_simple_pageVO> findNoticeInList(int no);
	public List<Board_categoryVO> readCategoryWithoutNotice(int no);
	public List<BoardVO> getRecentBoard(String name);
	public int deleteReply(Board_replyVO vo);
	public int delMotherCategory(Board_categoryVO cVo);
	public int delSonCategory(Board_categoryVO cVo);
}
