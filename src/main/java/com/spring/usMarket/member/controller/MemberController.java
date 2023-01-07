package com.spring.usMarket.member.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.catalina.Session;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.spring.usMarket.member.domain.MemberDto;
import com.spring.usMarket.member.service.MemberService;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/member")
@RequiredArgsConstructor
@SessionAttributes
public class MemberController {
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	private final MemberService memberService;
	
	@GetMapping("/login")
	public String login(MemberDto member) {
		return "member/login";
	}

	@PostMapping("/login")
	public void loginCheck(HttpServletRequest request, String member_id, String member_password, Model model) throws Exception {
		logger.info("ID 입력 정보 = "+member_id+", PW 입력 정보 = "+member_password);

		HttpSession httpSession = request.getSession(true);
		MemberDto member = memberService.loginCheckID(member_id);
		logger.info("회원정보 = " + member);
	
		if (member == null) {
			logger.info("아이디 없음");
			return;				
		}else if(member_password.equals(member.getMember_password())) {
			httpSession.setAttribute("userId", member);
		}else {
			logger.info("비밀번호 오류");
			return;
		}
			
	}
	
	@GetMapping("/logout.do")
	public String logout(HttpServletRequest request) throws Exception{
		logger.info("logout메서드 진입");
		HttpSession session = request.getSession();
		session.invalidate();
		return "redirect:/";
	}
	
}
