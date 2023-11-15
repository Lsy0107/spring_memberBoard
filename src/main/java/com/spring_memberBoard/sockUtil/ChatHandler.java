package com.spring_memberBoard.sockUtil;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.google.gson.Gson;

public class ChatHandler extends TextWebSocketHandler {

	private ArrayList<WebSocketSession> clientList = new ArrayList<WebSocketSession>();
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		System.out.println("채팅 페이지 접속");
		Map<String, Object> sessionAttrs = session.getAttributes();
		String loginId = (String)sessionAttrs.get("loginMemberId");
		
		Gson gson = new Gson();
		HashMap<String, String> msgInfo = new HashMap<String, String>();
		msgInfo.put("msgtype", "c");
		msgInfo.put("msgid", loginId);
		
		msgInfo.put("msgcomm", "님이 입장했습니다.");
		
		for(WebSocketSession client : clientList) {
			client.sendMessage( new TextMessage(gson.toJson(msgInfo)));
		}
		clientList.add(session);
		
		for(WebSocketSession client : clientList) {
			Map<String, Object> clientAttr = client.getAttributes();
			String clientMemberId = (String)clientAttr.get("loginMemberId");
			//A,B,C,D,E 한번씩 아이디를 추출해내는.. 
			
			HashMap<String, String>clientInfo = new HashMap<String, String>();
			clientInfo.put("msgtype", "c");
			clientInfo.put("msgid", clientMemberId);
			clientInfo.put("msgcomm", "님이 입장했습니다.");
			
			session.sendMessage(new TextMessage(new Gson().toJson(clientInfo)));
		}
	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		System.out.println("보낸 메세지 : " + (String)message.getPayload());
		Map<String, Object> sessionAttrs = session.getAttributes();
		String loginId = (String)sessionAttrs.get("loginMemberId");
		System.out.println("보내는 아이디 : " + loginId);
		
		Gson gson = new Gson();
		HashMap<String, String> msgInfo = new HashMap<String, String>();
		msgInfo.put("msgtype", "m");
		msgInfo.put("msgid", loginId);
		msgInfo.put("msgcomm", message.getPayload());
		
		for(WebSocketSession client : clientList) {
			if(!client.getId().equals(session.getId())) {
				client.sendMessage( new TextMessage( gson.toJson(msgInfo) ) );
			}
		}
		
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		System.out.println("채팅 페이지 접속해제");
		Map<String, Object> sessionAttrs = session.getAttributes();
		String loginId = (String)sessionAttrs.get("loginMemberId");
		clientList.remove(session);
		
		Gson gson = new Gson();
		HashMap<String, String> msgInfo = new HashMap<String, String>();
		msgInfo.put("msgtype", "d");
		msgInfo.put("msgid", loginId);
		msgInfo.put("msgcomm","님이 퇴장했습니다.");
		
		for(WebSocketSession client : clientList) {
			client.sendMessage( new TextMessage(gson.toJson(msgInfo)));
		}
	}

}
