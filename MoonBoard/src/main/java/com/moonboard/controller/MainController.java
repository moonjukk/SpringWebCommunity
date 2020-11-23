package com.moonboard.controller;

import java.security.Principal;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.moonboard.service.BoardService;
import com.moonboard.service.MemberService;

import lombok.AllArgsConstructor;

@Controller
@AllArgsConstructor
public class MainController {

	private BoardService boardService;
	private MemberService memberService;
	
	@GetMapping("/")
	public String main(Model model, Principal principal) {
		if(principal!=null) {
			//로그인 상태로 해당하는 닉네임을 읽어와야 함
			model.addAttribute("nickname", memberService.findNickname(principal.getName()));
			
			//회원이 관리하는 게시판번호 get
			int bno = memberService.findBoardNoByManager(principal.getName());
			if(bno>0) 
				model.addAttribute("manageBoardNo", bno);
			

			// 최근 댓글, 게시글을 조회하여 최근활동 커뮤니티 보여주기
			model.addAttribute("recentBoard", boardService.getRecentBoard(principal.getName()));
			System.out.println(boardService.getRecentBoard(principal.getName()));
		}
		
		//인기게시판 3개 출력
		model.addAttribute("topBoard", boardService.getTopBoard());
		
		return "main";
	}
}

