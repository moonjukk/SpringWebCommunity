package com.moonboard.domain;

import java.util.Date;
import java.util.List;

import com.moonboard.domain.ImageVO;

import lombok.Data;

@Data
public class Board_pageVO {

	private int pno;
	private int bno;
	private int cno;
	private String title;
	private String content;
	private String writer_userid;
	private Date write_date;
	private int heart;
	
	private List<ImageVO> imagelist;
	
}
/*
게시물 / pno(페이지번호) / bno(게시판번호)
create table moon_board_page(
    pno number primary key,
    bno number not null,
    title varchar2(40) not null,
    content varchar2(1000) not null,
    writer_userid varchar2(80) not null,
    write_date  timestamp DEFAULT sysdate NOT NULL,
    heart number default 0
);
*/