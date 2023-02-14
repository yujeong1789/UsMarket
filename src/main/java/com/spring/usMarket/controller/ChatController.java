package com.spring.usMarket.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
	public void list() {
		logger.info("chat/list");
	}
	
	@PostMapping("/add")
	public String add(Integer seller_no, String product_name, String seller_nickname, HttpServletRequest request, RedirectAttributes ratt) {
		Integer current_no = Integer.parseInt(SessionParameters.getUserNo(request));
		logger.info("seller_no = {}, current_no = {}", seller_no, current_no);
		try {
			ChatRoomDto dto = chatService.getChatRoomByInfo(seller_no, current_no);
			// null이면 새 채팅방 만들고 채팅 insert
			if(dto == null) {
				String chat_content = seller_nickname+"님, 판매 중인 "+product_name+" 상품에 문의사항이 있어요!";
				dto = chatService.addChatRoom(current_no, seller_no, chat_content);
			}
			ratt.addFlashAttribute("condition", "open");
			ratt.addFlashAttribute("room_no", dto.getRoom_no());
			ratt.addFlashAttribute("chat_from", current_no);
			ratt.addFlashAttribute("chat_to", seller_no);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/chat/list";
	}
}
