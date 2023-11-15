package com.spring_memberBoard.Service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.spring_memberBoard.dao.BoardDao;
import com.spring_memberBoard.dto.Boards;
import com.spring_memberBoard.dto.Replys;

@Service
public class BoardService {

	@Autowired
	BoardDao bdao;
	
	public int UploadService(Boards board, HttpSession session) throws IllegalStateException, IOException {
		System.out.println("UploadService()호출");
		//글 번호 생성
		int Bno = bdao.selectBno()+1;
		board.setBno(Bno);
		//업로드된 파일 저장 - 저장 경로 설정, 중복 파일명 처리
		MultipartFile bfile = board.getBfile(); //첨부파일
		String bfilename = ""; // 파일명 저장할 변수
		String savePath = session.getServletContext().getRealPath("/resources/boardUpload");
		if(!bfile.isEmpty()) { //첨부파일 확인 false= 첨부파일이 있음
			//첨부파일이 없는 경우
			//bfile.isEmpty() : 파일이 없는 경우 true
			//!bfile.isEmpty() : 파일이 있는 경우 true
			System.out.println("첨부파일 있음");
			//임의의 코드 + as.jpg
			UUID uuid = UUID.randomUUID();
			String code = uuid.toString();
			System.out.println("code : "+code);
			bfilename = code + "_"+bfile.getOriginalFilename();
			//저장할 경로 resources/boardUpload 폴더에 파일 저장
			//D:\spring_workspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\spring_memberBoard\resources\boardUpload
			System.out.println("savePath : "+savePath);
			File newFile = new File(savePath,bfilename);
			bfile.transferTo(newFile);
			
			board.setBfilename(bfilename);
			System.out.println(board);
		}else {
			//첨부파일이 있는 경우
			System.out.println("첨부파일 없음");
		}
		System.out.println("파일이름 : "+bfilename);
		board.setBfilename(bfilename);
		//업로드된 파일의 이름 추출 - bfilename
		
		
		int Upresult = bdao.UploadDao(board);
		
		return Upresult;
	}

	public ArrayList<Boards> ConBoardList() {
		System.out.println("ConBoardList()호출");
		
		/*
		 * 글번호가 1번인 글의 댓글 수 조회 
		 * */
		ArrayList<Boards> bResult = bdao.SelBoardList();
		System.out.println("bResult : " + bResult);
		for(Boards bo : bResult) {
			System.out.println(bo.getBno());
			int recount = bdao.selectBoardReount(bo.getBno());
			bo.setRecount(recount);
		}
		System.out.println("Recount 추가 후 bResult : "+bResult);
		return bResult;
	}
	
	public ArrayList<HashMap<String, String>> ConBoardList_map() {
		System.out.println("SERVICE - ConBoardList_map() 호출");
		
		return bdao.selectBoards_map();
	}

	public Boards BoardView(Boards board) {
		System.out.println("BoardView 호출");
		int UpdateHits = bdao.BoardHitsDao(board);
		
		Boards BoardServ = bdao.BoardViewDao(board);
		
		return BoardServ;
	}

	public Boards BoardFixService(Boards board) {
		System.out.println("BoardFixServuce() 호출");
		Boards boardFixDao = bdao.BoardFixDao(board);
		return boardFixDao;
	}

	public int BoardFixCom(Boards board) {
		System.out.println("BoardFixCom() 호출");
		int BFixDao = bdao.BoardFixComDao(board);
		return BFixDao;
	}

	//댓글작성 서비스
	public int SendCommentService(Replys replys) {
		System.out.println("SendCommentService");
		
		//글번호 지정 + 1 
		int renum = bdao.selectReNum(replys)+1;
		replys.setRenum(renum);
		
		int CommentINsert= 0;
		try {
			CommentINsert = bdao.SendCommentDao(replys);			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return CommentINsert;
	}

	public ArrayList<Replys> getReplyList(int rebno) {
		System.out.println("getReplyList() 호출");
		
		return bdao.getReplyDao(rebno);
	}

	public int deleteReply(int renum) {
		System.out.println("deleteReply() 호출");
		
		int DeleteBoard = bdao.deleteReply(renum);
		return DeleteBoard;
	}

	

	


}
