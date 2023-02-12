package com.usMarket.test;

import static org.junit.Assert.assertEquals;

import java.util.Date;
import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.transaction.annotation.Transactional;

import com.spring.usMarket.dao.chat.ChatDao;
import com.spring.usMarket.domain.chat.ChatDto;
import com.spring.usMarket.service.chat.ChatService;

@Transactional
@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class ChatServiceTest {
	
	@Autowired private ChatService chatService;
	@Autowired private ChatDao chatDao;
	@Test
	public void addChatTest() throws Exception{
		ChatDto dto = new ChatDto("20230209EGOWGWDPDB", 43, 1, "test content", new Date(), "N");
		int rowCnt = chatService.addChat(dto);
		assertEquals(rowCnt, 1);
		
		List<ChatDto> dto_ = chatDao.searchChatInfo(dto.getRoom_no());
		for(ChatDto chatDto : dto_) {
			System.out.println(chatDto.toString());
		}
	}
}
