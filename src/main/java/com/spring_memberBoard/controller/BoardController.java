package com.spring_memberBoard.controller;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.spring_memberBoard.Service.BoardService;
import com.spring_memberBoard.dto.Boards;
import com.spring_memberBoard.dto.Replys;

@Controller
public class BoardController {

	@Autowired
	BoardService bsvc;
	
	@RequestMapping(value = "/BoardWriteForm")
	public ModelAndView BoardWriteForm() {
		System.out.println("글작성 페이지 요청");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("Board/BoardWriteForm");

		return mav;
	}
	@RequestMapping(value="/BoardWrite")
	public ModelAndView BoardWrite(Boards board, HttpSession session,RedirectAttributes ra) {
		System.out.println("글 등록 요청");
		ModelAndView mav = new ModelAndView();		
		String bwriter = (String)session.getAttribute("loginMemberId");
		board.setBwriter(bwriter);
		System.out.println(board); //글 정보
		System.out.println(board.getBfile().getOriginalFilename()); //첨부파일 이름
		System.out.println(session.getServletContext().getRealPath("/resources/boardUpload"));
		String path=session.getServletContext().getRealPath("/resources/boardUpload");
		
		String bfilename = board.getBfile().getOriginalFilename();
		board.setBfilename(bfilename);
		
		System.out.println(board.getBfilename());
		int UploadResult=0;
		try {
			UploadResult = bsvc.UploadService(board,session);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if(UploadResult > 0) {
			System.out.println("글 등록 성공");
			mav.setViewName("redirect:/BoardList");
			ra.addFlashAttribute("noticeMsg","newBoard");
		}else {
			System.out.println("글 등록 실패");
			mav.setViewName("redirect:/BoardWriteForm");
		}
		
		return mav;
	}
	@RequestMapping(value="/BoardView")
	public ModelAndView boardView(HttpSession session,RedirectAttributes ra,Replys reply,Boards board,HttpServletRequest request, HttpServletResponse response) {
		System.out.println("글 상세 보기 요청");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("Board/BoardView");
		int ViewBno = Integer.parseInt(request.getParameter("ViewBno"));
		board.setBno(ViewBno);
		System.out.println("글번호 : "+ViewBno);
		
		
		//1.글 정보 조회
		Boards Bview = bsvc.BoardView(board);	
		//2.댓글 갯수 조회
		
		request.setAttribute("Bview", Bview);
		
		session.setAttribute("ViewBno",Bview.getBno());
		System.out.println(Bview);
		
		
		return mav;
	}
	
	@RequestMapping(value="/BoardList")
	public ModelAndView BoardList(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("게시판 이동 요청");
		ModelAndView mav = new ModelAndView();
		
		ArrayList<Boards> bList = bsvc.ConBoardList();
		mav.addObject("bList",bList);
		System.out.println(bList);
		
		//Hashmap - 글목록 조회
		//HashMap<String,String> map = null;
		ArrayList<HashMap<String,String> > bList_map = bsvc.ConBoardList_map();
		System.out.println(bList_map);
		mav.addObject("bListMap",bList_map);
		
		
		mav.setViewName("Board/BoardList");	
		return mav;
	}
	
	@RequestMapping(value="/BoardFix")
	public ModelAndView BoardFix(Boards board,HttpSession session,HttpServletRequest request, HttpServletResponse response) {
		System.out.println("게시물 수정 페이지 이동 요청");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("Board/BoardFix");
		int VBno= (int) session.getAttribute("ViewBno");
		System.out.println("글번호 : "+VBno);
		board.setBno(VBno);
		Boards boardfix = bsvc.BoardFixService(board);
		System.out.println(boardfix);
		request.setAttribute("Bview", boardfix);	
		return mav;
	}
	
	@RequestMapping(value="/fixComplete")
	public ModelAndView fixComplete(Boards board,RedirectAttributes ra,HttpSession session,HttpServletRequest request, HttpServletResponse response) {
		System.out.println("수정 요청");
		ModelAndView mav = new ModelAndView();
		int VBno= (int) session.getAttribute("ViewBno");
		System.out.println("글번호 : "+VBno);
		System.out.println(board.getBcontents());
		System.out.println(board.getBtitle());
		board.setBno(VBno);
		int bno = board.getBno();
		String title = board.getBtitle();
		String contents = board.getBcontents();
		try {
			
		} catch (NullPointerException e) {
			// TODO: handle exception
		}
		int BFix = bsvc.BoardFixCom(board);
		if(BFix>0) {
			System.out.println("수정 성공");
			mav.setViewName("redirect:/");
			ra.addFlashAttribute("msg","게시물 수정이 완료되었습니다.");
		}else {
			System.out.println("수정 실패");
			mav.setViewName("Board/BoardList");
			ra.addFlashAttribute("msg","게시물 수정 오류!");
		}
		return mav;
	}
	
	@RequestMapping(value="/replyWrite")
	public @ResponseBody String sendReComment(Replys replys,HttpSession session,HttpServletRequest request, HttpServletResponse response) {
		System.out.println("댓글 작성 기능");
		
		String UserId = (String)session.getAttribute("loginMemberId");
		replys.setRemid(UserId); //댓글작성자
		
		System.out.println(replys);
		
		int insertComment = bsvc.SendCommentService(replys);
		if(insertComment>0) {
			System.out.println("댓글작성 완료");
		}else {
			System.out.println("댓글작성 실패");
		}
		return insertComment+"";
	}
	@RequestMapping(value="/replyList")
	public @ResponseBody String replyList(int rebno) {
		System.out.println("댓글 조회 요청");
		System.out.println("댓글을 조회할 글번호 : "+rebno);
		
		// service - 댓글 목록 조회
		ArrayList<Replys> replyList = bsvc.getReplyList(rebno);
		
		//조회된 댓글 목록 확인
		System.out.println(replyList);
		
		//Json 변환 후 응답
		//gson 사용 -> maven 검색 후 gson 검색
		//gson {key : value}
		Gson gson = new Gson();
		String reList = gson.toJson(replyList);
		System.out.println(reList);
		return reList;
	}
	@RequestMapping(value = "/deleteReply")
	public @ResponseBody String  deleteReply(int renum) {
		System.out.println("댓글 삭제 요청 - /deleteReply");
		System.out.println("삭제할 댓글 번호 : " + renum);
		
		int result = bsvc.deleteReply(renum);
		
		return result+"";
	}
	
	
	
	
}
