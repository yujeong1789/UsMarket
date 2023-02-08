package com.spring.usMarket.dao.chat;

import com.spring.usMarket.domain.chat.ChatRoomDto;

public interface ChatDao {
	int insertChatRoom(ChatRoomDto dto) throws Exception;
	String searchNickName(Integer member_no) throws Exception;
}
