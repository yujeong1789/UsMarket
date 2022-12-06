package com.spring.usMarket.webSocket;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

// 핸들러 구현
public class MyHandler extends TextWebSocketHandler{
	
	private static List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		// 연결이 수립된 직후 실행
		
		System.out.println("connected! - "+session.toString());
		sessionList.add(session);
	}
		
		
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		// 클라이언트가 메세지를 보냈을 때 실행
		
		String name=searchName(session);
		
		for(WebSocketSession sess:sessionList) { // 연결되어있는 동안 실행
			//페이로드 - 헤더, 메타데이터 등 부수적인 정보 제외한 보내고자 하는 데이터
			sess.sendMessage(new TextMessage(name+": "+message.getPayload()));
		}
		
	}
	

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		// 연결이 끊어진 후 실행
		System.out.println("disConnected! - "+status);
		
		String name=searchName(session);
		
		for(WebSocketSession sess:sessionList) { // 연결되어있는 동안 실행
			//페이로드 - 헤더, 메타데이터 등 부수적인 정보 제외한 보내고자 하는 데이터
			sess.sendMessage(new TextMessage(name+"님과 연결이 끊어졌습니다."));
		}
		sessionList.remove(session);
	}
	
	
	// 세션에 저장된 사용자 이름 얻어오기
	public String searchName(WebSocketSession session) throws Exception{
		Map<String, Object>map=session.getAttributes();
		return (String)map.get("name");
	}

}
