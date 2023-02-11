package com.spring.usMarket.service.chat;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.usMarket.dao.chat.ChatDao;
import com.spring.usMarket.domain.chat.ChatDto;
import com.spring.usMarket.domain.chat.ChatRoomDto;
import com.spring.usMarket.utils.RandomString;

@Service
public class ChatServiceImpl implements ChatService{
	private static final Logger logger = LoggerFactory.getLogger(ChatService.class);
	
	@Autowired ChatDao chatDao;
	
	
	public String getResult(int rowCnt) {
		return rowCnt == 1 ? "OK" : "NOT_OK";
	}
	
	@Override
	@Transactional(rollbackFor = SQLException.class)
	public ChatRoomDto getChatRoom(Integer chat_member_1, Integer chat_member_2) throws Exception {
		
		ChatRoomDto dto = chatDao.searchChatRoom(chat_member_1, chat_member_2);
		
		if(dto == null) {
			// 새 채팅방 생성
			String room_no = RandomString.getRandomString(RandomString.yyyyMMdd, 10);
			dto = new ChatRoomDto(room_no, chat_member_1, chat_member_2);
			int rowCnt = chatDao.insertChatRoom(dto);
			logger.info("채팅방 생성 결과 ={}", getResult(rowCnt));
		}
		
		logger.info("dto.toString = {}", dto);
		
		return dto;
	}

	@Override
	@Transactional(rollbackFor = SQLException.class, readOnly = true)
	public List<Map<String, Object>> getChatList(Integer member_no) throws Exception {
		
		List<Map<String, Object>> chatListMap = chatDao.searchChatList(member_no);
		logger.info("chatListMap.toString() = {}", chatListMap.toString());
		
		return chatListMap;
	}

	@Override
	@Transactional(rollbackFor = SQLException.class)
	public List<ChatDto> getChatInfo(String room_no, String is_read, Integer chat_to) throws Exception {
		if(is_read == "N" || is_read.equals("N")) {
			int rowCnt = chatDao.updateChatRead(room_no, chat_to);
			logger.info("chat_read 업데이트 결과 = {}", rowCnt);
		}
		List<ChatDto> chatInfo = chatDao.searchChatInfo(room_no);
		logger.info("chatInfo.size() = {}", chatInfo.size());
		
		return chatInfo;
	}

}
