package com.moonboard.domain;

import java.util.Date;

import lombok.Data;

@Data
public class Board_simple_pageVO {

	private int pno;
	private int bno;
	private int cno;
	private String title;
	private String writer_userid;
	private String nickname;
	private Date write_date;
	private int heart;
	
}