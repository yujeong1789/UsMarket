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

import com.fasterxml.jackson.databind.ObjectMapper;
import com.spring.usMarket.domain.chat.ChatDto;

// 핸들러 구현
public class EchoHandler extends TextWebSocketHandler{
	
	private final ObjectMapper objectMapper = new ObjectMapper();
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
		JSONObject jsonObject = (JSONObject)new JSONParser().parse(message.getPayload());
		String type = jsonObject.get("type").toString();
		String msg = jsonObject.get("body").toString();
		
		logger.info("handleTextMessage senderNo = {}, type = {}, msg = {}", senderNo, type, msg);
		
		if(!msg.isEmpty() || msg != "") {
			ChatDto chatDto = objectMapper.readValue(msg, ChatDto.class);
			String receiverNo = String.valueOf(chatDto.getChat_to());
			if(sessionList.get(receiverNo) != null ) {
				WebSocketSession receiver = sessionList.get(receiverNo);
				receiver.sendMessage(new TextMessage(msg));
			}
			if(type == "chat" || type.equals("chat")) {
				logger.info("type = {} sendMessage", type);
				session.sendMessage(new TextMessage(msg));
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