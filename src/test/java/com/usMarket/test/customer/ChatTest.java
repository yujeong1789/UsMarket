package com.usMarket.test.customer;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import java.util.Date;
import java.util.List;
import java.util.Map;

import org.junit.FixMethodOrder;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.junit.runners.MethodSorters;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import com.spring.usMarket.dao.chat.ChatDao;
import com.spring.usMarket.domain.chat.ChatDto;
import com.spring.usMarket.domain.chat.ChatRoomDto;

@FixMethodOrder(MethodSorters.NAME_ASCENDING)
@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class ChatTest {
	
	@Autowired private ChatDao chatDao;
	
	private final int CURRENT_NO = 2; 
	private final int SELLER_NO = 3;
	private final String ROOM_NO = "dummy";
	
	@Test
	public void chatTest_1() throws Exception{
		// insertChatRoom
		ChatRoomDto chatRoomDto = new ChatRoomDto(ROOM_NO, CURRENT_NO, SELLER_NO);
		int insertRoomResult = chatDao.insertChatRoom(chatRoomDto);
		assertEquals(insertRoomResult, 1);
		
		// searchChatRoom
		ChatRoomDto chatRoomDto_ = chatDao.searchChatRoomByInfo(CURRENT_NO, SELLER_NO);
		assertNotNull(chatRoomDto_);
		
		// searchChatList
		List<Map<String, Object>> chatList = chatDao.searchChatList(CURRENT_NO);
		assertNotNull(chatList);
		
		// insertChat
		int insertChatResult = chatDao.insertChat(new ChatDto(ROOM_NO, CURRENT_NO, SELLER_NO, "test message", new Date(), "N", 0, "", ""));
		assertEquals(insertChatResult, 1);
		
		// searchChatInfo
		List<ChatDto> chatInfo = chatDao.searchChatInfo(ROOM_NO);
		assertEquals(chatInfo.size(), 1);
	}
	
	@Test
	public void chatTest_2() throws Exception{
		// updateChatRead
		int updateChatResult = chatDao.updateChatRead(ROOM_NO, SELLER_NO);
		assertEquals(updateChatResult, 1);
	}
	
	@Test
	public void chatTest_3() throws Exception{
		// deleteChatRoom
		int deleteChatRoomResult = chatDao.deleteChatRoom(ROOM_NO);
		assertEquals(deleteChatRoomResult, 1);
	}
}
