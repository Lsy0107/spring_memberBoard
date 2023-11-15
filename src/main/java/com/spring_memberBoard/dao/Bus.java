package com.spring_memberBoard.dao;

import lombok.Data;

@Data
public class Bus {

	private String nodenm;				//정류소명
	private String routeno;				//노선번호
	private String arrprevstationcnt;	//남은 정류장 수
	private String arrtime; 			//도착 예정 시간
	
}
