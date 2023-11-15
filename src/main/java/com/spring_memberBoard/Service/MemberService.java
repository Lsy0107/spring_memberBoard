package com.spring_memberBoard.Service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring_memberBoard.dao.MemberDao;
import com.spring_memberBoard.dto.Boards;
import com.spring_memberBoard.dto.Member;
import com.spring_memberBoard.dto.Replys;

@Service
public class MemberService {

	@Autowired
	private MemberDao mdao;
	
	public String idCheck(String inputId) {
		System.out.println("SERVICE - idCheck() 호출");
		System.out.println("아이디 : "+inputId);
		
		Member member = mdao.selectMemberInfo(inputId);
		
		Member member_mapper = mdao.selectMemberInfo_mapper(inputId);
		System.out.println(member_mapper);
		System.out.println(member);
		String result = "N";
		if(member ==null) {
			result = "Y";
		}else {
			result ="N";
		}	
		return result;
	}

	public int registMember(Member member) {
		System.out.println("SERVICE - registMember()호출");
		//DAO 호출 - INSERT INTO MEMBERS()
		int joinResult = 0;
		try {
			joinResult = mdao.insertMember(member); 			
		} catch (Exception e) {
			e.printStackTrace(); //e.printStackTrace() : 에러의 발생근원지를 찾아서 단계별로 에러를 출력합니다.
		}
		
		return joinResult;
	}

	public Member getLoginMemberInfo(String mid, String mpw) {
		System.out.println("SERVICE - getLoginMemberInfo() 호출");
		Member loginResult = null;
		try {
			loginResult = mdao.loginMember(mid,mpw);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return loginResult;
	}

	public Member ViewMyInfo(Member member) {
		System.out.println("ViewMyInfo()호출");
		
		Member mInfoDao = mdao.ViewMyDaoInfo(member);
		return mInfoDao;
	}

	public int UpdatePassword(Member member) {
		System.out.println("UpdatePassword() 호출");
		
		int UpdatePwDao=0;
		try {
			UpdatePwDao = mdao.UpdatePw(member);			
		} catch (Exception e) {
			e.printStackTrace();
		}	
		return UpdatePwDao;
	}

	public String ReplyCount(Replys reply) {
		System.out.println("ReplyCount() 호출");
		
		String ReplyCountService = mdao.ReplyCountDao(reply);
		
		return ReplyCountService;
	}

	public String BoardCount(Boards board) {
		System.out.println("BoardCount() 호출");
		
		String BoardCountService = mdao.BoardCountDao(board);
		return BoardCountService;
	}

}
