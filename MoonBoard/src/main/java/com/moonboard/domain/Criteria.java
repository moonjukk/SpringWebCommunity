package com.moonboard.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class Criteria {
	private int cno; // 카테고리num
	private int pageNum;
	private int amount;
	private String type;
	private String searchList;
	private String keyword;
	
	public Criteria() {
		this(0,1,10, "");
	}
	
	public Criteria(int cno, int pageNum,int amount, String type) {
		this.cno = cno;
		this.pageNum = pageNum;
		this.amount = amount;
		this.type = type;
	}

}
