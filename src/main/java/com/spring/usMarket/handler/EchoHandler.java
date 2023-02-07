package com.spring.usMarket.handler;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

// 핸들러 구현
public class EchoHandler extends TextWebSocketHandler{
	private static final Logger logger = LoggerFactory.getLogger(EchoHandler.class);
	
	// private static List<WebSocketSession> sessionList = new ArrayList<WebSocketSession>();
	private static Map<String, WebSocketSession> sessionList = new ConcurrentHashMap<>();
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		// 연결이 수립된 직후 실행
		logger.info("connected! session.getId() = {}", session.getId());
		// sessionList.add(session);
		sessionList.put(session.getId(), session);
	}
		
		
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		// 클라이언트가 메세지를 보냈을 때 실행
		
		logger.info("handleTextMessage {}: {}", session.getId(), message);
		
		/*for(WebSocketSession sess : sessionList) { // 연결되어있는 동안 실행
			//페이로드 - 헤더, 메타데이터 등 부수적인 정보 제외한 보내고자 하는 데이터
			sess.sendMessage(new TextMessage(session.getId()+": "+message.getPayload()));
		}*/
		
		String msg = message.getPayload(); // js에서 보낸 세션 아이디 값
		for(WebSocketSession sess : sessionList.values()) {
			if(sess != null) {
				sess.sendMessage(new TextMessage(session.getId()+": "+message.getPayload()));				
			}
		}
		
	}
	

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		// 연결이 끊어진 후 remove로 해당 세션 제거
		logger.info("disConnected! session.getId() = {}", session.getId());
		sessionList.remove(session.getId());
	}
	
	
	/*
	// 세션에 저장된 사용자 이름 얻어오기
	public String searchId(WebSocketSession session) throws Exception{
		Map<String, Object>map=session.getAttributes();
		return (String)map.get("userId");
	}*/

}