package com.spring.usMarket.dao.chat;

import java.util.List;
import java.util.Map;

import com.spring.usMarket.domain.chat.ChatDto;
import com.spring.usMarket.domain.chat.ChatRoomDto;

public interface ChatDao {
	ChatRoomDto searchChatRoom(Integer chat_member_1, Integer chat_member_2) throws Exception;
	int insertChatRoom(ChatRoomDto dto) throws Exception;
	String searchNickName(Integer member_no) throws Exception;
	List<Map<String, Object>> searchChatList(Integer member_no) throws Exception;
	List<ChatDto> searchChatInfo (String room_no) throws Exception;
}
