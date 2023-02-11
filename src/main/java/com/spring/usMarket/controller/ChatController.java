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
	public String add(Integer chat_member_1, Integer chat_member_2, HttpServletRequest request, RedirectAttributes ratt) {
		logger.info(chat_member_1+", "+chat_member_2);
		try {
			ChatRoomDto dto = chatService.getChatRoom(chat_member_1, chat_member_2);
			ratt.addFlashAttribute("condition", "open");
			ratt.addFlashAttribute("room_no", dto.getRoom_no());
			
			if(dto.getChat_member_1() == Integer.parseInt(SessionParameters.getUserNo(request))) {
				ratt.addFlashAttribute("chat_from", dto.getChat_member_1());
				ratt.addFlashAttribute("chat_to", dto.getChat_member_2());
			} else {
				ratt.addFlashAttribute("chat_from", dto.getChat_member_2());
				ratt.addFlashAttribute("chat_to", dto.getChat_member_1());
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/chat/list";
	}
}
