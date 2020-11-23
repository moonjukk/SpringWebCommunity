package com.moonboard.controller;

import java.io.File;
import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.moonboard.domain.BoardVO;
import com.moonboard.domain.Board_categoryVO;
import com.moonboard.domain.Board_pageVO;
import com.moonboard.domain.Board_replyVO;
import com.moonboard.domain.ImageVO;
import com.moonboard.service.BoardService;
import com.moonboard.service.MemberService;

import lombok.AllArgsConstructor;

@Controller
@RequestMapping("/setting/*")
@PreAuthorize("isAuthenticated()")
@AllArgsConstructor
public class SettingController {

	private BoardService boardService;
	private MemberService memberService;
	
	@PostMapping(value="/change",
			consumes = "application/json",
			produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> title(@RequestBody BoardVO bVo, Principal principal){
		
		System.out.println(bVo+" 의 정보를 변경 시도..."+ principal.getName());
		
		String change = bVo.getChange();
		// 1. 접속한 회원의 정보가 매니저가 맞는지 확인
		if(!memberService.findManagerId(bVo.getNo()).equals(principal.getName())){
			new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		int successCnt = 0;
		if(change.equals("title")) {
			// board의 title을 수정, 완료되면 successCnt값을 1 아니면 0 을 리턴 (change값이 title인경우 title을 수정)
			successCnt = boardService.changeTitle(bVo);
		}else if(change.equals("subtitle")) {
			// board의 subtitle을 수정,
			successCnt = boardService.changeSubTitle(bVo);
		}
		
		return successCnt == 1
				? new ResponseEntity<>("Success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	// 카테고리 관련 setting
	@PostMapping(value="/changeCategory",
			consumes = "application/json",
			produces = { MediaType.TEXT_PLAIN_VALUE })
	public ResponseEntity<String> category(@RequestBody Board_categoryVO cVo, Principal principal){
		
		System.out.println(cVo+" 의 정보를 변경 시도..."+ principal.getName());
		
		String change = cVo.getChange();
		// 1. 접속한 회원의 정보가 매니저가 맞는지 확인
		if(!memberService.findManagerId(cVo.getPno()).equals(principal.getName())){
			new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
		
		int successCnt = 0;
		if(change.equals("makeMotherCategory")) {
			// board의 title을 수정, 완료되면 successCnt값을 1 아니면 0 을 리턴 (change값이 title인경우 title을 수정)
			cVo.setDepth(1);
			successCnt = boardService.makeMotherCategory(cVo);
		}else if(change.equals("makeSonCategory")) {
			// board의 title을 수정, 완료되면 successCnt값을 1 아니면 0 을 리턴 (change값이 title인경우 title을 수정)
			cVo.setDepth(2);
			successCnt = boardService.makeSonCategory(cVo);
		}else if(change.equals("delMotherCategory")) {
			// 부모카테고리를삭제, 완료되면 successCnt값을 1 아니면 0 을 리턴 (change값이 title인경우 title을 수정)
			successCnt = boardService.delMotherCategory(cVo);
		}else if(change.equals("delSonCategory")) {
			// 부모카테고리를삭제, 완료되면 successCnt값을 1 아니면 0 을 리턴 (change값이 title인경우 title을 수정)
			successCnt = boardService.delSonCategory(cVo);
		}
		
		return successCnt == 1
				? new ResponseEntity<>("Success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	
	
	
	// 커뮤니티 메인페이지의 배너이미지 변경
		@PostMapping(value="/changeBanner",
				consumes = "application/json",
				produces = { MediaType.TEXT_PLAIN_VALUE })
		public ResponseEntity<String> banner(@RequestBody ImageVO iVo, Principal principal){
			
			System.out.println(iVo+" 의 정보를 변경 시도..."+ principal.getName());
			int type = iVo.getType();
			
			// 1. 접속한 회원의 정보가 매니저가 맞는지 확인
			if(!memberService.findManagerId(iVo.getBno()).equals(principal.getName())){
				new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
			}
			
			int successCnt = 0;
			
			if(type<3) {
				// type이 1이면 커뮤니티 페이지의 메인베너
				// 완료되면 successCnt값을 1 아니면 0 을 리턴 (change값이 title인경우 title을 수정)
				successCnt = boardService.inputBanner(iVo);
			}
			
			return successCnt == 1
					? new ResponseEntity<>("Success", HttpStatus.OK)
					: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
		}
	
	
}

