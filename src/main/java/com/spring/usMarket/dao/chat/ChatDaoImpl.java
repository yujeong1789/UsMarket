package com.spring.usMarket.dao.chat;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.usMarket.domain.chat.ChatRoomDto;

@Repository
public class ChatDaoImpl implements ChatDao{

	@Autowired
	private SqlSession session;
	private static String namespace = "com.mybatis.mapper.chat.";
	
	@Override
	public int insertChatRoom(ChatRoomDto dto) throws Exception {
		return session.insert(namespace+"insertChatRoom", dto);
	}

	@Override
	public String searchNickName(Integer member_no) throws Exception {
		return session.selectOne(namespace+"searchNickName", member_no);
	}

}
