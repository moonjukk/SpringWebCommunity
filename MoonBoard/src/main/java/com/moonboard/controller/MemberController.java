package com.moonboard.controller;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.moonboard.domain.UserVO;
import com.moonboard.service.MemberService;

import lombok.AllArgsConstructor;
import lombok.Setter;

@Controller
@RequestMapping("/member/*")
@AllArgsConstructor
public class MemberController {
	
	@Setter(onMethod_ = @Autowired)
	private PasswordEncoder pwencoder;
	
	private MemberService memberService;
	
	@GetMapping("/customLogin")
	public void loginInput(UserVO uVo, String error, String logout, Model model, String message) {
		
		if(error != null) {
			model.addAttribute("error", "아이디 혹은 비밀번호를 확인해주세요");
		}
		
		if(logout != null) {
			model.addAttribute("logout", "로그아웃되었습니다.");
		}
		System.out.println(message);
		if(message != null) {
			model.addAttribute("message", message);
		}
		
	}
	
	@GetMapping("/join")
	public void main() {
	}
	
	@PostMapping("/join")
	public String joinPost(UserVO uVo, Model model) {
		
		System.out.println(uVo);
		
		//먼저 id중복체크
		int idCheck = memberService.idCheck(uVo.getUserid());
		
		String pw = pwencoder.encode(uVo.getPw());
		uVo.setPw(pw);
		
		System.out.println("id중복체크 : "+idCheck);
		System.out.println("pw 인코딩 : "+pw);
		
		if(idCheck<1) {
			// 중복이 아닌경우 mapper에 insert
			// 새로운 user는 "ROLE_USER";
			memberService.userRegister(uVo);
			
			model.addAttribute("message", uVo.getUserid()+" 님 회원가입에 성공하였습니다!");
			return "/board/go_main";
		}else {
			// 중복인 경우
			model.addAttribute("message", "중복되는 id입니다");
			model.addAttribute("returnName", uVo.getUsername());
			//model.addAttribute("returnPhone", uVo.getUserphonenum());
			
			return "/member/join";
		}
		
	}
	
	@GetMapping("/customLogout")
	public void customLogoutGet() {}
	@PostMapping("/customLogout")
	public void customLogoutPost() {}
	
}

