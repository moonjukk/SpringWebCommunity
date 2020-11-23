package com.moonboard.domain;

import lombok.Data;

@Data
public class BoardVO {

	private int no;
	private String title;
	private String subtitle;
	private int color;
	
	private String manager_userid;
	
	private int total_page;
	
	// 설정 변경시 사용하는 변수
	private String change;
	
	// 메인화면에서 배너이미지 보이게하기
	private String uuid;
	private String uploadpath;
	private String filename;
}
/*
no number PRIMARY KEY,
title varchar2(40) not null,
subtitle varchar2(60),
color number default '1'
*/