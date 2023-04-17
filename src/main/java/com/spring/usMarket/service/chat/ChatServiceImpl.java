package com.spring.usMarket.service.chat;

import java.sql.SQLException;
import java.util.Date;
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
	@Transactional(rollbackFor = SQLException.class, readOnly = true)
	public ChatRoomDto getChatRoomByInfo(Integer chat_member_1, Integer chat_member_2) throws Exception {
		
		ChatRoomDto dto = chatDao.searchChatRoomByInfo(chat_member_1, chat_member_2);
		
		return dto;

	}
	
	@Override
	@Transactional(rollbackFor = SQLException.class)
	public ChatDto addChatRoom(Integer current_no, Integer seller_no, String message, Integer chat_type, String chat_info) throws Exception {
		
		String room_no = RandomString.getRandomString(RandomString.yyyyMMdd, 10);
		ChatRoomDto dto = new ChatRoomDto(room_no, current_no, seller_no);
		int rowCnt = chatDao.insertChatRoom(dto);
		logger.info("채팅방 생성 결과 = {}", getResult(rowCnt));
		ChatDto chatDto = new ChatDto();
		if(rowCnt == 1) {
			chatDto = new ChatDto(room_no, current_no, seller_no, message, new Date(), "N", chat_type, chat_info);
			logger.info("chatDto.toString = {}", chatDto.toString());
			
			int rowCnt_ = chatDao.insertChat(chatDto);
			logger.info("채팅 전송 결과 = {}", getResult(rowCnt_));
		}
		
		return chatDto;
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
	public int modifyChatRead(String room_no, Integer chat_to) throws Exception {
		
		int rowCnt = chatDao.updateChatRead(room_no, chat_to);
		logger.info("chat_read 업데이트 결과 = {}", rowCnt);
		
		return rowCnt;
	}

	@Override
	@Transactional(rollbackFor = SQLException.class, readOnly = true)
	public List<ChatDto> getChatInfo(String room_no) throws Exception {
		
		List<ChatDto> chatInfo = chatDao.searchChatInfo(room_no);
		logger.info("chatInfo.size() = {}", chatInfo.size());
		
		return chatInfo;
	}
	
	@Override
	@Transactional(rollbackFor = SQLException.class)
	public int addChat(ChatDto dto) throws Exception {
		
		int rowCnt = chatDao.insertChat(dto);
		logger.info("채팅 전송 결과 = {}", getResult(rowCnt));
		
		return rowCnt;
	}

	@Override
	@Transactional(rollbackFor = SQLException.class, readOnly = true)
	public Map<String, Object> getChatMember(Integer member_no) throws Exception {
		
		Map<String, Object> chatMemberMap = chatDao.searchChatMember(member_no);
		logger.info("chatMemberMap.toString() = {}", chatMemberMap.toString());
		
		return chatMemberMap;
	}

	@Override
	@Transactional(rollbackFor = SQLException.class, readOnly = true)
	public int getNewChat(Integer member_no) throws Exception {
		
		int rowCnt = chatDao.searchNewChat(member_no);
		logger.info("읽지 않은 메세지 = {}", rowCnt);
		
		return rowCnt;
	}


}
