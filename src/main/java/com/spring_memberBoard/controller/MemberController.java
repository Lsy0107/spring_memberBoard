package com.spring_memberBoard.controller;

import javax.naming.directory.SchemaViolationException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring_memberBoard.Service.MemberService;
import com.spring_memberBoard.dto.Boards;
import com.spring_memberBoard.dto.Member;
import com.spring_memberBoard.dto.Replys;


@Controller
public class MemberController {
	
	@Autowired
	private MemberService msvc;
	
	
	@RequestMapping(value="memberJoinForm")
	public ModelAndView MemberJoinOn() {
		System.out.println("MemberJoinOn 호출");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("member/memberJoinForm");
		
		return mav;
	}
	@RequestMapping(value="/idCheck")
	public @ResponseBody String memberIdCheck(String inputId) {
		System.out.println("아이디 중복 확인 요청");
		System.out.println("확인할 아이디 : "+inputId);
		//1.서비스 호출 - 아이디 중복 확인 기능
		// MEMBERS테이블의 MID 컬럼에 저장된 아이디 인지 확인
		// SELECT * FROM MEMBERS WHERE MID = #{mid};
		String checkResult = msvc.idCheck(inputId);
		
		//2.확인 결과 반환 Y:사용가능 N:사용불가능
		return checkResult;
	}
	@RequestMapping(value = "/memberJoin")
	public ModelAndView memberJoin(Member member, String memailId, String memailDomain, RedirectAttributes ra) {
		ModelAndView mav = new ModelAndView();
		// 가입할 회원 정보 파라메터 확인
		System.out.println(member);
		System.out.println("회원가입 요청");
		System.out.println(memailId);
		System.out.println(memailDomain);
		member.setMemail(memailId+"@"+memailDomain);
		// SERVICE - 회원가입 기능 호출 - INSERT INTO MEMBERS
		int joinResult = msvc.registMember(member);
		/*view/Success.jsp
		 * <script>
		 * alert(${msg});
		 * location.href="${url}";
		 * </script>
			mav.setViewName("Success"); // 성공했을때 갈 페이지
			mav.addObject("msg","회원가입에 성공 했습니다.");
			mav.addObject("url","/mainpage");
		 * */
		
		/* redirect:/ */
		if(joinResult > 0) {
			System.out.println("가입 성공");
			mav.setViewName("redirect:/");
			ra.addFlashAttribute("msg","회원가입에 성공 했습니다."); //1회용 Flash
			
		} else {
			System.out.println("가입 실패");
			mav.setViewName("redirect:/MemberJoinForm"); // 실패했을때 갈 페이지 (회원가입 페이지)
			ra.addFlashAttribute("msg","회원가입에 실패하였습니다.");
		}
		
		return mav;
	}
	/*1. 로그인 페이지 이동 요청에 대한 처리 /memberLoginForm */
	@RequestMapping(value="/MemberLoginForm")
	public ModelAndView memberLoginForm() {
		System.out.println("로그인 페이지 이동 요청");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("Member/MemberLoginForm");
		return mav;
	}
	/*2. 로그인 요청에 대한 처리 /memberLogin */
	@RequestMapping(value="/memberLogin")
	public ModelAndView memberLogin(HttpSession session,String mid,String mpw , RedirectAttributes ra) {
		System.out.println("로그인 처리 요청 - /memberLogin");
		ModelAndView mav = new ModelAndView();
		//1.로그인할 아이디, 비밀번호 파라메터 확인
		System.out.println("입력한 아이디 : "+mid);
		System.out.println("입력한 비밀번호 : "+mpw);
		//2.SERVICE - 로그인 회원정보 조회 호출
		Member loginMember = msvc.getLoginMemberInfo(mid,mpw);		
		if(loginMember == null) {
			System.out.println("로그인 실패");
			/*로그인 페이지로 이동*/
			mav.setViewName("redirect:/MemberLoginForm");
			ra.addFlashAttribute("msg","로그인 실패하였습니다");
			
		}else {
			System.out.println("로그인 성공");
			session.setAttribute("loginMemberId",loginMember.getMid());
			mav.setViewName("redirect:/");
			ra.addFlashAttribute("msg","로그인에 성공했습니다.");
			/*메인 페이지로 이동*/
		}
		return mav;
	}
	
	@RequestMapping(value="MemberLogOut")
	public ModelAndView MemberLogOut(HttpSession session, RedirectAttributes ra) {
		System.out.println("로그아웃 호출");
		ModelAndView mav = new ModelAndView();
		session.removeAttribute("loginMemberId");
		
		mav.setViewName("redirect:/");
		ra.addFlashAttribute("msg","로그아웃 되었습니다.");
		return mav;
	}
	
	@RequestMapping(value="MyInfo")
	public ModelAndView MyInfo(Boards board,Replys reply,Member member,HttpSession session,RedirectAttributes ra,HttpServletRequest request, HttpServletResponse response) {
		System.out.println("내정보 조회 페이지");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("Member/MyInfo");
		String loginId = (String)session.getAttribute("loginMemberId");
		member.setMid(loginId);
		reply.setRemid(loginId);
		board.setBwriter(loginId);
		Member mInfo = msvc.ViewMyInfo(member);
		
		String RepInfo = msvc.ReplyCount(reply);
		String BoardInfo = msvc.BoardCount(board);
		System.out.println("작성한 댓글 갯수 : "+RepInfo);
		System.out.println("작성한 글 갯수 : "+BoardInfo);
		System.out.println(mInfo);
		mav.addObject("BoardInfo",BoardInfo);
		mav.addObject("RepInfo",RepInfo);
		
		session.setAttribute("mInfo", mInfo);
		request.setAttribute("mInfo", mInfo);
		return mav;
	}
	
	@RequestMapping(value="MyInfoFix")
	public ModelAndView MyInfoFix(Member member,HttpSession session,RedirectAttributes ra) {
		System.out.println("정보 수정 페이지");
		ModelAndView mav = new ModelAndView();
		mav.setViewName("Member/MyInfoFix");
		Member getInfo = (Member)session.getAttribute("mInfo");
		member.setMname(getInfo.getMname());

		System.out.println(getInfo);
		return mav;
	}
	@RequestMapping(value="infoFix")
	public ModelAndView infoFix(String memailId,String memailDomain,Member member,HttpSession session,RedirectAttributes ra) {
		System.out.println("비밀번호 변경controller");
		ModelAndView mav = new ModelAndView();
		String loginId = (String)session.getAttribute("loginMemberId");
		System.out.println(loginId);
		System.out.println(member.getMpw());
		member.setMid(loginId);
		member.setMemail(memailId+"@"+memailDomain);
		
		mav.addAllObjects(null);
		int UpdatePw = msvc.UpdatePassword(member);
		if(UpdatePw>0) {
			System.out.println("비밀번호 변경 성공");
			mav.setViewName("redirect:/");
		}else {
			System.out.println("비밀번호 변경 실패");
			mav.setViewName("Member/MyInfoFix");
		}
		return mav;
	}


}

