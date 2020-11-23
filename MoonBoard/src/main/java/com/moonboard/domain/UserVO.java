package com.moonboard.domain;

import lombok.Data;

@Data
public class UserVO {
	private String userid;
	private String pw;
	private String nickname;
	private String username;
	private char enabled;
}

/*
userid(PK)
pw
nickname
username
enabled '1'
create table moon_user(
    userid varchar2(80) primary key,
	pw varchar2(100) NOT NULL,
    nickname varchar2(20) NOT NULL,
	username varchar2(20) NOT NULL,
    -- 기본값 1이아니면 로그인이 불가능 - 스프링시큐리티
	enabled char(1) DEFAULT '1' NOT NULL
);
*/