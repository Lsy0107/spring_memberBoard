package com.spring_memberBoard.dto;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class Boards {
	private int bno;
	private String bwriter;
	private String btitle;
	private String bcontents;
	private int bhits;
	private String bdate;
	private String bfilename;
	private String bstate;
	private MultipartFile bfile;
	
	private int recount;
}
