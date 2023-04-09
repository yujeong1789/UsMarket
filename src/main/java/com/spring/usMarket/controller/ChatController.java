package com.spring.usMarket.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.spring.usMarket.domain.chat.ChatDto;
import com.spring.usMarket.domain.chat.ChatRoomDto;
import com.spring.usMarket.service.chat.ChatService;
import com.spring.usMarket.utils.SessionParameters;

@Controller
@RequestMapping("/chat")
public class ChatController {
	private static final Logger logger = LoggerFactory.getLogger(ChatController.class);
	
	@Autowired
	ChatService chatService;
	
	
	@GetMapping("/list")
	public void list(RedirectAttributes ratt, HttpServletRequest request, Model model) {
		Integer current_no = Integer.parseInt(SessionParameters.getUserNo(request));
		
		Map<String, ?> flashMap = RequestContextUtils.getInputFlashMap(request);
		if(flashMap != null) {
			logger.info("flashMap.toString() = {}", flashMap.toString());
			model.addAttribute("room_no", flashMap.get("room_no"));
		}
		
		List<Map<String, Object>> chatList = new ArrayList<>();
		try {
			chatList = chatService.getChatList(current_no);
		} catch (Exception e) {
			e.printStackTrace();
		}
		model.addAttribute("chatList", chatList);
	}
	
	
	@PostMapping("/add")
	public String add(Integer seller_no, String product_name, String seller_nickname, HttpServletRequest request, RedirectAttributes ratt) {
		Integer current_no = Integer.parseInt(SessionParameters.getUserNo(request));
		logger.info("seller_no = {}, current_no = {}", seller_no, current_no);
		try {
			ChatRoomDto dto = chatService.getChatRoomByInfo(seller_no, current_no);
			ChatDto chatDto = new ChatDto();
			// null이면 새 채팅방 만들고 채팅 insert
			if(dto == null) {
				String chat_content = seller_nickname+"님, 판매 중인 "+product_name+" 상품에 문의사항이 있어요!";
				chatDto = chatService.addChatRoom(current_no, seller_no, chat_content);
				ratt.addFlashAttribute("chatDto", new ObjectMapper().writeValueAsString(chatDto));
				ratt.addFlashAttribute("room_no", chatDto.getRoom_no());
			}else {
				ratt.addFlashAttribute("room_no", dto.getRoom_no());
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/chat/list";
	}
}
