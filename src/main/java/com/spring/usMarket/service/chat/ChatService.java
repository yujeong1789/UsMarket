package com.spring.usMarket.service.chat;

import java.util.List;
import java.util.Map;

import com.spring.usMarket.domain.chat.ChatDto;
import com.spring.usMarket.domain.chat.ChatRoomDto;

public interface ChatService {
	ChatRoomDto getChatRoom(Integer chat_member_1, Integer chat_member_2) throws Exception;
	List<Map<String, Object>> getChatList(Integer member_no) throws Exception;
	List<ChatDto> getChatInfo (String room_no, String is_read, Integer chat_to) throws Exception;
}
