package com.spring.usMarket.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.usMarket.domain.chat.ChatRoomDto;
import com.spring.usMarket.service.chat.ChatService;

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
	public String add(ChatRoomDto dto, HttpServletRequest request, RedirectAttributes ratt) {
		logger.info(dto.toString());
		try {
			int rowCnt = chatService.addChatRoom(dto);
			ratt.addFlashAttribute("condition", "add");
			
			if(dto.getChat_member_1() == Integer.parseInt(getUserNo(request))) {
				ratt.addFlashAttribute("chat_from", dto.getChat_member_1());
				ratt.addFlashAttribute("chat_to", dto.getChat_member_2());
			}else {
				ratt.addFlashAttribute("chat_from", dto.getChat_member_2());
				ratt.addFlashAttribute("chat_to", dto.getChat_member_1());
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/chat/list";
	}
	
    private String getUserNo(HttpServletRequest request) {
        // 1. 세션을 얻어서
        HttpSession session = request.getSession();
        // 2. 세션에 id가 있는지 확인, 있으면 true를 반환
        return String.valueOf(request.getSession().getAttribute("userNo"));
    }
}
