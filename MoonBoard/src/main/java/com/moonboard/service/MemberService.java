package com.moonboard.service;

import java.util.List;

import com.moonboard.domain.BoardVO;
import com.moonboard.domain.Board_categoryVO;
import com.moonboard.domain.Board_pageVO;
import com.moonboard.domain.Board_simple_pageVO;
import com.moonboard.domain.Criteria;
import com.moonboard.domain.ImageVO;
import com.moonboard.domain.UserVO;

public interface MemberService {
	
	public int idCheck(String userid);
	
	// 회원가입
	public void userRegister(UserVO uVo);
	
	//회원 아이디로 닉네임 찾기
	public String findNickname(String userid);

	public int findBoardNoByManager(String manager_userid);

	public String findManagerId(int no);

		
	// auth 주입
	//public void authRegister(UserVO uVo);
	
}
