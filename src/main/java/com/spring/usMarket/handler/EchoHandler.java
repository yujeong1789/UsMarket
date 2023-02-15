package com.spring.usMarket.handler;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

// 핸들러 구현
public class EchoHandler extends TextWebSocketHandler{
	
	private static final Logger logger = LoggerFactory.getLogger(EchoHandler.class);
	private static Map<String, WebSocketSession> sessionList = new ConcurrentHashMap<>();
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		
		String senderNo = String.valueOf(session.getAttributes().get("userNo"));
		logger.info("connected! senderNo = {}", senderNo);
		
		sessionList.put(senderNo, session);
		
		logger.info("sessionList.size() = {}", sessionList.size());
	}
		
		
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		
		String senderNo = String.valueOf(session.getAttributes().get("userNo"));
		logger.info("handleTextMessage senderNo = {}, payload = {}", senderNo, message.getPayload().toString());
		
		String msg = message.getPayload();
		
		if(!msg.isEmpty()) {
			JSONParser jsonParser = new JSONParser();
			JSONObject jsonObject = (JSONObject)jsonParser.parse(msg);
			
			String receiverNo = String.valueOf(jsonObject.get("chat_to"));
			String chatContent = String.valueOf(jsonObject.get("chat_content"));
			
			if(sessionList.get(receiverNo) != null) {
				WebSocketSession receiver = sessionList.get(receiverNo);
				receiver.sendMessage(new TextMessage(chatContent));
			}
		}
		
	}
	

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		
		String senderNo = String.valueOf(session.getAttributes().get("userNo"));
		logger.info("disConnected! senderNo = {}", senderNo);
		
		sessionList.remove(senderNo);
	}

}