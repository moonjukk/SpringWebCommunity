package com.moonboard.controller;

import java.io.File;
import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.annotations.Param;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.moonboard.domain.ImageVO;
import com.moonboard.domain.BoardVO;
import com.moonboard.domain.Board_pageVO;
import com.moonboard.domain.Board_replyVO;
import com.moonboard.domain.Criteria;
import com.moonboard.domain.PageDTO;
import com.moonboard.service.BoardService;
import com.moonboard.service.MemberService;

import lombok.AllArgsConstructor;

@Controller
@RequestMapping("/board/*")
@AllArgsConstructor
public class BoardController {
	
	private BoardService boardService;
	private MemberService memberService;

	@GetMapping("/home")
	public void home(@RequestParam("no") int no, Model model, Principal principal, @Param("message") String message) {
		
		if(principal!=null) {
			//로그인 상태로 해당하는 닉네임을 읽어와야 함
			model.addAttribute("nickname", memberService.findNickname(principal.getName()));
			// 로그인한 회원의 아이디
			model.addAttribute("loginUserId", principal.getName());
		}
		// no로 게시판의 관리자 id
		model.addAttribute("boardManagerID", boardService.getBoardManagerID(no));
		// no로 게시판의 정보 읽어오기
		model.addAttribute("getBoardData", boardService.read(no));
		// no로 게시판의 카테고리 읽어오기
		model.addAttribute("categoryList", boardService.readCategory(no));
		
		
		// 메인배너 읽어오기
		model.addAttribute("mainBannerImg", boardService.readMainBanner(no));
		// 상단배너 읽어오기
		model.addAttribute("topBannerImg", boardService.readTopBanner(no));
		
		// 필독공지사항 최대 10개 읽어오기
		model.addAttribute("noticeList", boardService.findNotice(no));
		model.addAttribute("no",no);
		model.addAttribute("cno",boardService.findNoticeNo(no));
		
		
		if(message != null) {
	         if(message.equals("er1")) {
	             model.addAttribute("message", "접근 권한이 없습니다.");
	         }
	    }
		
		
	}
	
	@GetMapping("/list")
	public String list(@RequestParam("no") int no, Model model, Criteria cri, Principal principal) {
		
		if(principal!=null) {
			//로그인 상태로 해당하는 닉네임을 읽어와야 함
			model.addAttribute("nickname", memberService.findNickname(principal.getName()));
			// 로그인한 회원의 아이디
			model.addAttribute("loginUserId", principal.getName());
		}
		// no로 게시판의 관리자 id
		model.addAttribute("boardManagerID", boardService.getBoardManagerID(no));
		// no로 게시판의 정보 읽어오기
		model.addAttribute("getBoardData", boardService.read(no));
		// no로 게시판의 카테고리 읽어오기
		model.addAttribute("categoryList", boardService.readCategory(no));
		// cno를 통해 category_name찾기
		model.addAttribute("categoryName", boardService.getCategoryName(cri.getCno()));
		// cno(moon_board_page의 bno)를 통해 게시글 목록 불러오기(페이징)
		model.addAttribute("list",boardService.getListWithPaging(cri));
		model.addAttribute("no",no);
		model.addAttribute("cno",cri.getCno());
		model.addAttribute("pageMaker",new PageDTO(cri, boardService.getTotalCount(cri.getCno())));
		
		if(boardService.findNoticeNo(no) != cri.getCno()) {
			// 필독공지사항 최대 2개 읽어오기
			model.addAttribute("noticeList", boardService.findNoticeInList(no));
			model.addAttribute("notice_cno",boardService.findNoticeNo(no));
		}

		// 상단배너 읽어오기
		model.addAttribute("topBannerImg", boardService.readTopBanner(no));
		
		return "/board/board_list";
	}
	
	@GetMapping("/write")
	@PreAuthorize("isAuthenticated()")
	public String write(@RequestParam("no") int no, Model model, Principal principal) {
		
		//로그인 상태로 해당하는 닉네임을 읽어와야 함
		model.addAttribute("nickname", memberService.findNickname(principal.getName()));
		// 로그인한 회원의 아이디
		model.addAttribute("loginUserId", principal.getName());
		
		String managerId = boardService.getBoardManagerID(no);
		if(managerId.equals(principal.getName())) {
			// 매니저라면 공지사항을 포함한 카테고리 글쓰기 가능
			model.addAttribute("categoryList2", boardService.readCategory(no));
		}else {
			// 매니저가 아니라면 공지사항을 제외한 나머지 카테고리 글쓰기 가능
			model.addAttribute("categoryList2", boardService.readCategoryWithoutNotice(no));
		}
		
		// no로 게시판의 관리자 id
		model.addAttribute("boardManagerID", boardService.getBoardManagerID(no));
		// no로 게시판의 정보 읽어오기
		model.addAttribute("getBoardData", boardService.read(no));
		// no로 게시판의 카테고리 읽어오기
		model.addAttribute("categoryList", boardService.readCategory(no));

		// 상단배너 읽어오기
		model.addAttribute("topBannerImg", boardService.readTopBanner(no));
		
		return "/board/board_write";
	}
	
	@PostMapping("/write")
	public String write(RedirectAttributes rttr, Board_pageVO bpVo, Principal principal) {
		System.out.println(bpVo);
		
		// 게시물 작성자는 로그인되어있는 회원
		bpVo.setWriter_userid(principal.getName());
		// bpVo의 데이터를 저장하고, 저장된 데이터의 pno(페이지번호)를 불러와야함
		int pno = boardService.write(bpVo);
		// 게시판번호와 함께 리다이렉트
		int where_board = bpVo.getBno();
		return "redirect:/board/page?no="+where_board+"&pno="+pno+"&cno="+bpVo.getCno();
		
	}
	
	
	@GetMapping("/page")
	public String page(@RequestParam("no") int no, @RequestParam("pno") int pno, @RequestParam("cno") int cno,Model model, Principal principal) {
		
		if(principal!=null) {
			//로그인 상태로 해당하는 닉네임을 읽어와야 함
			model.addAttribute("nickname", memberService.findNickname(principal.getName()));
			// 로그인한 회원의 아이디
			model.addAttribute("loginUserId", principal.getName());
		}
		// no로 게시판의 관리자 id
		model.addAttribute("boardManagerID", boardService.getBoardManagerID(no));
		// no로 게시판의 정보 읽어오기
		model.addAttribute("getBoardData", boardService.read(no));
		// no로 게시판의 카테고리 읽어오기
		model.addAttribute("categoryList", boardService.readCategory(no));
		// cno를 통해 category_name찾기
		model.addAttribute("categoryName", boardService.getCategoryName(cno));
		// page내용 읽어오기
		Board_pageVO bpVo = boardService.readPage(pno);
		model.addAttribute("getPageData", bpVo);
		// page 작성자의 닉네임 읽어오기
		model.addAttribute("writer_nickname", memberService.findNickname(bpVo.getWriter_userid()));
		// page의 이미지 불러오기
		model.addAttribute("imgListData", boardService.findPageImg(pno));

		// 상단배너 읽어오기
		model.addAttribute("topBannerImg", boardService.readTopBanner(no));
		
		
		return "/board/board_page";
	}
	
	
	
	// 댓글 읽어오기
	@GetMapping(value="/getReply/{pno}",
			produces = { MediaType.APPLICATION_XML_VALUE ,
						 MediaType.APPLICATION_JSON_UTF8_VALUE})
	public ResponseEntity<List<Board_replyVO>> getReplyList(@PathVariable("pno") int pno){
		System.out.println(boardService.getReplyList(pno));
		return new ResponseEntity<>(boardService.getReplyList(pno), HttpStatus.OK);
	}
	
	
	
	
	// 댓글 등록
	@PostMapping(value="/riply/new",
			consumes = "application/json",
			produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> create1(@RequestBody Board_replyVO vo){
		System.out.println(vo);
		int insertCount = boardService.registeReply(vo);

		//return new ResponseEntity<>("Success", HttpStatus.OK);
		
		return insertCount == 1
				? new ResponseEntity<>("Success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	
	
	
	
	
	// 대댓글 등록
	@PostMapping(value="/riplies/new",
			consumes = "application/json",
			produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> create2(@RequestBody Board_replyVO vo){
		System.out.println("대댓글 : "+vo);
		int insertCount = boardService.registeReply_rereply(vo);

		//return new ResponseEntity<>("Success", HttpStatus.OK);
		
		return insertCount == 1
				? new ResponseEntity<>("Success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	// 댓글 삭제
		@PostMapping(value="/riplies/delete",
				consumes = "application/json",
				produces = { MediaType.TEXT_PLAIN_VALUE })
		public ResponseEntity<String> delete(@RequestBody Board_replyVO vo){
			System.out.println("댓글삭제 : "+vo);
			int insertCount = boardService.deleteReply(vo);

			//return new ResponseEntity<>("Success", HttpStatus.OK);
			
			return insertCount == 1
					? new ResponseEntity<>("Success", HttpStatus.OK)
					: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		
		
	
	
	// 게시판 만들기
	@GetMapping("/makeBoard")
	public String makeBoard() {
		return "/board/make_board";
	}
	@PostMapping("/makeBoard")
	public String makeBoard(RedirectAttributes rttr, BoardVO bVo, Principal principal) {
		
		System.out.println(bVo);
		
		// 게시물 작성자는 로그인되어있는 회원
		String manager_userid = principal.getName();
		bVo.setManager_userid(manager_userid);
		// 유저정보로 이미 만들어진 게시판이 있는지 확인
		int check = boardService.checkManager(manager_userid);
		//이미 게설되어있다면 alert_NoMakeBoard로 이동
		if(check!=0)
			return "redirect:/alert/cant_make_board";
		// 게시판 게설 및 매니저 설정
		boardService.makeBoard(bVo);
		// 완료되었다면 alert_makeBaord로 이동
		return "redirect:/alert/make_board";
		//return "redirect:/board/page?no="+where_board+"&pno="+pno+"&cno="+bpVo.getCno();
	}
	
	
	// search
	// 댓글 읽어오기
		@GetMapping(value="/getSearchBoard/{currentVal}",
				produces = { MediaType.APPLICATION_XML_VALUE ,
							 MediaType.APPLICATION_JSON_UTF8_VALUE})
		public ResponseEntity<List<BoardVO>> getSearchBoard(@PathVariable("currentVal") String title){
			System.out.println("aweewwwwwwwwwwwwwwwwwwwwwww  :   "+title);
			System.out.println(boardService.getSearchBoard(title));
			return new ResponseEntity<>(boardService.getSearchBoard(title), HttpStatus.OK);
		}
	
	
	
	// 게시판 설정
	@GetMapping("/setting")
	@PreAuthorize("isAuthenticated()")
	public String setting(@RequestParam("no") int no, Model model, Principal principal) {
		
		// 1. 접속자가 게시판의 관리자가 맞는지 확인
		String manager_userid = memberService.findManagerId(no);
		System.out.println("접속시도 .... "+ principal.getName());
		
		if(principal==null || !manager_userid.equals(principal.getName())) {
			return "redirect:/board/home?no="+no+"&message=er1";
		}else {
			// 로그인한 회원의 아이디
			model.addAttribute("loginUserId", principal.getName());
			//로그인 상태로 해당하는 닉네임을 읽어와야 함
			model.addAttribute("nickname", memberService.findNickname(principal.getName()));
			// no로 게시판의 관리자 id
			model.addAttribute("boardManagerID", boardService.getBoardManagerID(no));
			// no로 게시판의 정보 읽어오기
			model.addAttribute("getBoardData", boardService.read(no));
			// no로 게시판의 카테고리 읽어오기
			model.addAttribute("categoryList", boardService.readCategory(no));
			
			// 상단배너 읽어오기
			model.addAttribute("topBannerImg", boardService.readTopBanner(no));
			
			return "/board/board_setting";
		}
		
		
		
		
	}
	
	
	
	@PostMapping(value = "/registerfiles", 
			  produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
			@ResponseBody
			public ResponseEntity<List<ImageVO>> uploadAjaxPost(MultipartFile[] uploadFile) {

				/* 
				 * 파일선택 or 드래그 시 서버에 업로드
				 */
		 		List<ImageVO> list = new ArrayList<>();
				String uploadFolder = "C:\\upload";
				
				// 폴더생성(연)
				String uploadFolderPathYear = getFolderPrev2();
				File uploadPath3 = new File(uploadFolder, uploadFolderPathYear);
				if(uploadPath3.exists() == false) {
					uploadPath3.mkdir();
					System.out.println("upload 폴더("+uploadFolderPathYear+")생성....");
				}
				
				// 폴더생성(월)
				String uploadFolderPathMonth = getFolderPrev();
				File uploadPath2 = new File(uploadFolder, uploadFolderPathMonth);
				if(uploadPath2.exists() == false) {
					uploadPath2.mkdir();
					System.out.println("upload 폴더("+uploadFolderPathMonth+")생성....");
				}
				
				// 폴더생성(일)
				String uploadFolderPath = getFolder();
				File uploadPath = new File(uploadFolder, uploadFolderPath);
				if(uploadPath.exists() == false) {
					uploadPath.mkdir();
					System.out.println("upload 폴더("+uploadPath+")생성....");
				}
				
				for(MultipartFile multipartFile : uploadFile) {
					ImageVO attachDTO = new ImageVO();
					String uploadFileName = multipartFile.getOriginalFilename();
					
					//IE
					uploadFileName = uploadFileName.substring(uploadFileName.lastIndexOf("\\")+1);

					// attachDTO에 정보 저장
					attachDTO.setFilename(uploadFileName);
					
					//uuid 생성
					UUID uuid = UUID.randomUUID();
					uploadFileName = uuid.toString() + "_" + uploadFileName;
					
					//File saveFile = new File(uploadFolder, uploadFileName);
					File saveFile = new File(uploadPath, uploadFileName);
					
					try {
						multipartFile.transferTo(saveFile);
						System.out.println("파일저장...."+uploadFileName);
						
						attachDTO.setUuid(uuid.toString());
						attachDTO.setUploadpath(uploadFolderPath);
						System.out.println(attachDTO);
						//리스트에 추가
						list.add(attachDTO);
						
					}catch(Exception e) {
						System.out.println(" !!!!!!!!!!!!! 업로드 에러 : "+e.getMessage());
					}
				}
				return new ResponseEntity<>(list, HttpStatus.OK);
			}
			
		 	private String getFolderPrev2() {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy");
				Date date = new Date();
				String str = sdf.format(date);
				return str.replace("-", File.separator);
			}
		 	private String getFolderPrev() {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
				Date date = new Date();
				String str = sdf.format(date);
				return str.replace("-", File.separator);
			}
			private String getFolder() {
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
				Date date = new Date();
				String str = sdf.format(date);
				return str.replace("-", File.separator);
			}
}

