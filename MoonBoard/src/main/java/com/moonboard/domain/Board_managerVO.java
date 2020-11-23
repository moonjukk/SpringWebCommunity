package com.moonboard.domain;

import lombok.Data;

@Data
public class Board_managerVO {

	private int no;
	private String manager_userid;
	
}
/*
create table moon_board_manager(
	no number PRIMARY KEY,
	manager_userid varchar2(80) not null
);
*/