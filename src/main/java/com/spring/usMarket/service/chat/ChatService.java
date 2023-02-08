package com.spring.usMarket.service.chat;

import com.spring.usMarket.domain.chat.ChatRoomDto;

public interface ChatService {
	int addChatRoom(ChatRoomDto dto) throws Exception;
	String getNickName(Integer member_no) throws Exception;
}
