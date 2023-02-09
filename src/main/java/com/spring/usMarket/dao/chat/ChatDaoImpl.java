package com.spring.usMarket.dao.chat;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.usMarket.domain.chat.ChatDto;
import com.spring.usMarket.domain.chat.ChatRoomDto;

@Repository
public class ChatDaoImpl implements ChatDao{

	@Autowired
	private SqlSession session;
	private static String namespace = "com.mybatis.mapper.chat.";
	
	@Override
	public ChatRoomDto searchChatRoom(Integer chat_member_1, Integer chat_member_2) throws Exception {
		Map<String, Integer> map = new HashMap<>();
		map.put("chat_member_1", chat_member_1);
		map.put("chat_member_2", chat_member_2);
		
		return session.selectOne(namespace+"searchChatRoom", map);
	}
	
	@Override
	public int insertChatRoom(ChatRoomDto dto) throws Exception {
		System.out.println(dto.getRoom_no());
		return session.insert(namespace+"insertChatRoom", dto);
	}

	@Override
	public String searchNickName(Integer member_no) throws Exception {
		return session.selectOne(namespace+"searchNickName", member_no);
	}

	@Override
	public List<Map<String, Object>> searchChatList(Integer member_no) throws Exception {
		return session.selectList(namespace+"searchChatList", member_no);
	}

	@Override
	public List<ChatDto> searchChatInfo(String room_no) throws Exception {
		return session.selectList(namespace+"searchChatInfo", room_no);
	}

}
