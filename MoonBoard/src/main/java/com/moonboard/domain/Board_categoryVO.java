package com.moonboard.domain;

import lombok.Data;

@Data
public class Board_categoryVO {

	private int cno;
	private int pno;
	private String category_name;
	private int depth;
	private int pcno;
	
	// 설정 변경시 사용하는 변수
	private String change;
	
	
}
/*
pno 부모게시판번호 / cno 카테고리번호 / pcno 부모카테고리번호
create table moon_board_category(
    pno number not null,
    cno number PRIMARY KEY,
    category_name varchar2(80) not null,
    depth number default 1,
    pcno number
);
*/