package com.spring_memberBoard.sockUtil;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class SockController {

	@RequestMapping(value = "/memberChatPage")
	public String memberChatPage(HttpSession session) {
		System.out.println("채팅 페이지 이동요청");
		String loginMemberId = (String)session.getAttribute("loginMemberId");
		if(loginMemberId == null) {
			
			return "Member/MemberLoginForm";
			
		}
		
		return "ChatPage";
	}
}

