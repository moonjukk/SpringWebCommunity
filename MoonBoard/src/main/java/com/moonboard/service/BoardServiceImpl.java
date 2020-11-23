package com.moonboard.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.moonboard.domain.BoardVO;
import com.moonboard.domain.Board_categoryVO;
import com.moonboard.domain.Board_pageVO;
import com.moonboard.domain.Board_replyVO;
import com.moonboard.domain.Board_simple_pageVO;
import com.moonboard.domain.Criteria;
import com.moonboard.domain.ImageVO;
import com.moonboard.mapper.BoardMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;


@AllArgsConstructor
@Service
public class BoardServiceImpl implements BoardService {
	
	@Setter(onMethod_ = @Autowired)
	private BoardMapper boardMapper;

	@Override
	public BoardVO read(int no) {
		BoardVO bVo = boardMapper.read(no);
		return bVo;
	}

	@Override
	public List<Board_categoryVO> readCategory(int no) {
		return boardMapper.readCategory(no);
	}

	@Override
	public String getCategoryName(int cno) {
		return boardMapper.getCategoryName(cno);
	}

	@Override
	public int write(Board_pageVO bpVo) {
		boardMapper.write(bpVo);
		
		if(bpVo.getImagelist() == null || bpVo.getImagelist().size()<=0) {
			return boardMapper.getPagenum(bpVo);
		}
		
		bpVo.getImagelist().forEach(attach -> {
			attach.setGno(bpVo.getPno());
			boardMapper.imageInsert(attach);
		});
		
		return boardMapper.getPagenum(bpVo);
	}
	
	@Override
	public Board_pageVO readPage(int pno) {
		return boardMapper.readPage(pno);
	}

	@Override
	public List<Board_simple_pageVO> getListWithPaging(Criteria cri) {
		return boardMapper.getListWithPaging(cri);
	}

	@Override
	public int getTotalCount(int cno) {
		return boardMapper.getTotalCount(cno);
	}

	@Override
	public int registeReply(Board_replyVO vo) {
		boardMapper.registeReply(vo);
		return 1;
	}

	@Override
	public List<Board_replyVO> getReplyList(int pno) {
		return boardMapper.getReplyList(pno);
	}

	@Override
	public int registeReply_rereply(Board_replyVO vo) {
		boardMapper.registeReply_rereply(vo);
		return 1;
	}

	@Override
	public int checkManager(String manager_userid) {
		int check = boardMapper.checkManager(manager_userid);
		
		if(check == 0)
			return 0;
		else
			return 1;
			
	}

	@Override
	public void makeBoard(BoardVO bVo) {
		boardMapper.makeBoard(bVo);
		int no = boardMapper.getBoardNo(bVo);
		bVo.setNo(no);
		// 매니저 설정
		boardMapper.setManager(bVo);
		// 기본 카테고리 생성
		Board_categoryVO cVo = new Board_categoryVO();
		cVo.setPno(bVo.getNo());
		cVo.setDepth(1);
		cVo.setCategory_name("공지사항");
		System.out.println(" test :: "+cVo);
		boardMapper.makeMotherCategory(cVo);
		int pcno1 = boardMapper.getParentCategoryCNO(cVo);
		cVo.setCategory_name("커뮤니티");
		boardMapper.makeMotherCategory(cVo);
		int pcno2 = boardMapper.getParentCategoryCNO(cVo);

		cVo.setDepth(2);
		cVo.setCategory_name("필독공지");
		cVo.setPcno(pcno1);
		boardMapper.makeSonCategory(cVo);
		cVo.setCategory_name("자유게시판");
		cVo.setPcno(pcno2);
		boardMapper.makeSonCategory(cVo);
	}

	@Override
	public List<BoardVO> getTopBoard() {
		return boardMapper.getTopBoard();
	}

	@Override
	public String getBoardManagerID(int no) {
		return boardMapper.getBoardManagerID(no);
	}

	@Override
	public List<ImageVO> findPageImg(int pno) {
		return boardMapper.findPageImg(pno);
	}

	@Override
	public int changeTitle(BoardVO bVo) {
		boardMapper.changeTitle(bVo);
		return 1;
	}

	@Override
	public int changeSubTitle(BoardVO bVo) {
		boardMapper.changeSubTitle(bVo);
		return 1;
	}

	@Override
	public int makeMotherCategory(Board_categoryVO cVo) {
		boardMapper.makeMotherCategory(cVo);
		return 1;
	}

	@Override
	public int makeSonCategory(Board_categoryVO cVo) {
		
		
		
		boardMapper.makeSonCategory(cVo);
		return 1;
	}

	
	@Override
	public int inputBanner(ImageVO iVo) {
		// 1.moon_board_image에 같은 bno 같은 type의 이미지가있다면 제거를함
		boardMapper.removeBanner(iVo);
		// 2. DB에 insert
		if(iVo.getType()>0) {
			boardMapper.insertBanner(iVo);
		}
		
		return 1;
	}

	@Override
	public ImageVO readMainBanner(int no) {
		return boardMapper.readMainBanner(no);
	}

	@Override
	public ImageVO readTopBanner(int no) {
		return boardMapper.readTopBanner(no);
	}

	@Override
	public List<BoardVO> getSearchBoard(String title) {
		return boardMapper.getSearchBoard(title);
	}

	@Override
	public List<Board_simple_pageVO> findNotice(int no) {
		int noticeNo = boardMapper.findNoticeNo(no);
		return boardMapper.findNoticeInHome(noticeNo);
	}

	@Override
	public int findNoticeNo(int no) {
		return boardMapper.findNoticeNo(no);
	}

	@Override
	public List<Board_simple_pageVO> findNoticeInList(int no) {
		int noticeNo = boardMapper.findNoticeNo(no);
		return boardMapper.findNoticeInList(noticeNo);
	}

	@Override
	public List<Board_categoryVO> readCategoryWithoutNotice(int no) {
		// 1.해당 게시판의 공지사항 상위카테고리 번호를 체크해야함
		int noticeNo = boardMapper.findNoticePcno(no); 
		// 2. 해당 번호를 pcno로 갖지않는 게시판no의 카테고리만 출력함
		System.out.println("test ::: "+no);
		return boardMapper.readCategoryWithoutNotice(no, noticeNo);
	}

	@Override
	public List<BoardVO> getRecentBoard(String name) {
		return boardMapper.getRecentBoard(name);
	}

	@Override
	public int deleteReply(Board_replyVO vo) {
		boardMapper.deleteReply(vo);
		return 1;
	}

	@Override
	public int delMotherCategory(Board_categoryVO cVo) {
		boardMapper.delMotherCategory(cVo);
		return 1;
	}

	@Override
	public int delSonCategory(Board_categoryVO cVo) {
		boardMapper.delSonCategory(cVo);
		return 1;
	}


}
