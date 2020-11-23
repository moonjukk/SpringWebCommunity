package com.moonboard.domain;

import lombok.Data;

@Data
public class ImageVO {

	private int gno;
	private String uuid;
	private String uploadpath;
	private String filename;
	private char thumbnail;

	private String selectedImg; // select태그 사용하기 위한 임시변수, db에는 존재하지않음
	
	private int ino; // moon_board_image에서만 사용, 이미지 번호
	private int bno; // moon_board_image에서만 사용, 게시판번호
	private int type;  // moon_board_image에서만 사용, 배너의 종류
	
}
