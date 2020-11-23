package com.moonboard.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.moonboard.domain.BoardVO;
import com.moonboard.domain.Board_categoryVO;
import com.moonboard.domain.Board_pageVO;
import com.moonboard.domain.Board_simple_pageVO;
import com.moonboard.domain.Criteria;
import com.moonboard.domain.ImageVO;
import com.moonboard.domain.UserVO;
import com.moonboard.mapper.BoardMapper;
import com.moonboard.mapper.MemberMapper;

import lombok.AllArgsConstructor;
import lombok.Setter;


@AllArgsConstructor
@Service
public class MemberServiceImpl implements MemberService {
	
	private MemberMapper MemberMapper;

	@Override
	public int idCheck(String userid) {
		return MemberMapper.idCheck(userid);
	}
	
	@Override
	@Transactional
	public void userRegister(UserVO uVo) {
		// 회원정보 insert
		MemberMapper.userRegister(uVo);
		// auth insert
		MemberMapper.authRegister(uVo);
	}

	// 회원 아이디로 닉네임 찾기
	@Override
	public String findNickname(String userid) {
		return MemberMapper.findNickname(userid);
	}

	@Override
	public int findBoardNoByManager(String manager_userid) {
		int beforeCheck = MemberMapper.beforeCheck_findBoardNoByManager(manager_userid);
		
		if(beforeCheck>0)
			return MemberMapper.findBoardNoByManager(manager_userid);
		else
			return -1;
	}

	@Override
	public String findManagerId(int no) {
		return MemberMapper.findManagerId(no);
	}

	


	

}
