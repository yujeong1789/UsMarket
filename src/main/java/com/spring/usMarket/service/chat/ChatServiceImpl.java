package com.spring.usMarket.service.chat;

import java.sql.SQLException;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.usMarket.dao.chat.ChatDao;
import com.spring.usMarket.domain.chat.ChatRoomDto;

@Service
public class ChatServiceImpl implements ChatService{
	private static final Logger logger = LoggerFactory.getLogger(ChatService.class);
	
	@Autowired ChatDao chatDdao;
	
	
	public String getResult(int rowCnt) {
		return rowCnt == 1 ? "OK" : "NOT_OK";
	}
	
	
	@Override
	@Transactional(rollbackFor = SQLException.class)
	public int addChatRoom(ChatRoomDto dto) throws Exception {
		
		int rowCnt = chatDdao.insertChatRoom(dto);
		logger.info("채팅방 개설 여부 = {}", getResult(rowCnt));
		
		return rowCnt;
	}


	@Override
	@Transactional(rollbackFor = SQLException.class, readOnly = true)
	public String getNickName(Integer member_no) throws Exception {
		
		String result = chatDdao.searchNickName(member_no);
		logger.info("닉네임 = {}", result);
		
		return result;
	}

}
