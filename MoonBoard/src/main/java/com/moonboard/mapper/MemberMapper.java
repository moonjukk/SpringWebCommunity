package com.moonboard.mapper;

import java.util.List;

import com.moonboard.domain.UserVO;
import com.moonboard.domain.BoardVO;
import com.moonboard.domain.Board_categoryVO;
import com.moonboard.domain.Board_pageVO;
import com.moonboard.domain.Board_simple_pageVO;
import com.moonboard.domain.Criteria;
import com.moonboard.domain.ImageVO;

public interface MemberMapper {
	// id 중복체크
	public int idCheck(String userid);
		
	// 회원가입
	public void userRegister(UserVO uVo);
		
	// auth 주입
	public void authRegister(UserVO uVo);

	// 회원아이디로 닉네임 찾기
	public String findNickname(String userid);

	public int findBoardNoByManager(String manager_userid);

	public int beforeCheck_findBoardNoByManager(String manager_userid);

	public List<ImageVO> findPageImg(int pno);

	public String findManagerId(int no);
	
}
