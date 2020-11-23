package com.moonboard.domain;

import java.util.Date;

import lombok.Data;

@Data
public class Board_replyVO {

	private int pno;
	private int rno;
	private String reply_userid;
	private String reply_comment;
	private Date reply_date;
	private int reply_parentno;
	private int depth;
	
	private String nickname;
	
}
/*
pno 게시글번호
rno 댓글에 부여될 고유번호 (대댓글 후순위)
reply_userid
reply_comment
reply_date
reply_parentno(대댓글 후순위)
depth(대댓글 후순위)
create table moon_board_reply(
    pno number not null,
    rno number not null,
    reply_userid varchar2(80) not null,
    reply_comment varchar2(800) not null,
    reply_date timestamp DEFAULT sysdate NOT NULL,
    reply_parentno number,
    depth number default 1
);
*/