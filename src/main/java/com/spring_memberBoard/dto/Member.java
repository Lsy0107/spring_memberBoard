package com.spring_memberBoard.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class Member {
	private String mid;
	private String mpw;
	private String mname;
	private String mbirth;
	private String memail;
	private String mstate;
	
	private MultipartFile[] mfile;
	
}
