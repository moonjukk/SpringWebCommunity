package com.moonboard.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.moonboard.domain.BoardVO;
import com.moonboard.domain.Board_categoryVO;
import com.moonboard.domain.Board_pageVO;
import com.moonboard.domain.Board_replyVO;
import com.moonboard.domain.Board_simple_pageVO;
import com.moonboard.domain.Criteria;
import com.moonboard.domain.ImageVO;

public interface BoardMapper {
	// 게시판 정보를 read
	public BoardVO read(int no);
	// 게시판의 카테고리 정보를 read
	public List<Board_categoryVO> readCategory(int no);
	public String getCategoryName(int cno);
	public void write(Board_pageVO bpVo);
	public int getPagenum(Board_pageVO bpVo);
	public Board_pageVO readPage(int pno);
	public List<Board_simple_pageVO> getListWithPaging(Criteria cri);
	public int getTotalCount(int cno);
	public void registeReply(Board_replyVO vo);
	public List<Board_replyVO> getReplyList(int pno);
	public void registeReply_rereply(Board_replyVO vo);
	public int checkManager(String manager_userid);
	public void makeBoard(BoardVO bVo);
	public int getBoardNo(BoardVO bVo);
	public void setManager(BoardVO bVo);
	public void makeMotherCategory(Board_categoryVO cVo);
	public int getParentCategoryCNO(Board_categoryVO cVo);
	public void makeSonCategory(Board_categoryVO cVo);
	public List<BoardVO> getTopBoard();
	public String getBoardManagerID(int no);
	public void imageInsert(ImageVO iVo);
	public List<ImageVO> findPageImg(int pno);
	public void changeTitle(BoardVO bVo);
	public void changeSubTitle(BoardVO bVo);
	public void removeBanner(ImageVO iVo);
	public void insertBanner(ImageVO iVo);
	public ImageVO readMainBanner(int no);
	public ImageVO readTopBanner(int no);
	public List<BoardVO> getSearchBoard(String title);
	public int findNoticeNo(int no);
	public List<Board_simple_pageVO> findNoticeInHome(int noticeNo);
	public List<Board_simple_pageVO> findNoticeInList(int noticeNo);
	public int findNoticePcno(int no);
	public List<Board_categoryVO> readCategoryWithoutNotice(@Param("no") int no, @Param("noticeNo") int noticeNo);
	public List<BoardVO> getRecentBoard(String name);
	public void deleteReply(Board_replyVO vo);
	public void delMotherCategory(Board_categoryVO cVo);
	public void delSonCategory(Board_categoryVO cVo);
}
