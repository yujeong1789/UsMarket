package com.spring.usMarket.controller;

import java.util.Map;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.usMarket.domain.member.MemberDto;
import com.spring.usMarket.domain.member.MemberFileDto;
import com.spring.usMarket.service.member.MemberFileService;
import com.spring.usMarket.service.member.MemberService;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/member")
@RequiredArgsConstructor
public class MemberController {
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	private final MemberFileService fileService;
	private final MemberService memberService;
	private final JavaMailSender mailSender;

	@GetMapping("/login")
	public String login(MemberDto member) {
		return "member/login";
	}

	@PostMapping("/login")
	public String loginCheck(HttpServletRequest request, String member_id, String member_password, Model model)
			throws Exception {
		logger.info("ID 입력 정보 = " + member_id + ", PW 입력 정보 = " + member_password);

		Map<String, Object> member = memberService.loginCheckID(member_id);
		logger.info("회원정보 = " + member);

		HttpSession httpSession = request.getSession(true);
		if (member == null) {
			logger.info("아이디 없음");
			String msg = "잘못된 입력입니다.";
			model.addAttribute("msg", msg);
			model.addAttribute("mem_id", member_id);
			model.addAttribute("mem_pw", member_password);
			return "member/login";
		} else if (member_password.equals(member.get("MEMBER_PASSWORD"))) {
			logger.info("로그인 성공");
			httpSession.setAttribute("userId", member_id);
			httpSession.setAttribute("userNo", member.get("MEMBER_NO"));
			return "redirect:/";
		} else {
			logger.info("비밀번호 오류");
			String msg = "잘못된 입력입니다.";
			model.addAttribute("msg", msg);
			model.addAttribute("mem_id", member_id);
			model.addAttribute("mem_pw", member_password);
			return "member/login";
		}

	}

	@GetMapping("/logout")
	public String logout(HttpServletRequest request) throws Exception {
		logger.info("logout메서드 진입");
		HttpSession session = request.getSession();
		session.invalidate();
		return "redirect:/";
	}

	@GetMapping("/join")
	public String join(MemberDto member) {
		return "member/join";
	}

	@PostMapping("/join")
	public String join(@ModelAttribute MemberDto member,MultipartHttpServletRequest request, Model model) {
		try {
			// 1. 회원 등록
			logger.info("memberDto = {}",member.toString());
			if(member.getMember_image() == null) {
				member.setMember_image("profil.png");
			}
			int result = memberService.addMember(member);
			
			if(result != 1) {
				logger.info("회원가입 실패");
				return "redirect:/member/join";
			}
			
			/*
			 * // 2. 파일 업로드 logger.info("MultipartHttpServletRequest = {}",request);
			 * MemberFileDto list = fileService.upload(request.getFile("member_img"),
			 * member.getMember_no());
			 * 
			 * // 3. 파일 db에 insert int rowCnt = memberService.addMemberFile(list);
			 * logger.info("addMemberFile result = {}", (rowCnt ));
			 */
		} catch (Exception e) {
			model.addAttribute("message", "회원가입에 실패 했습니다.");
			e.printStackTrace();
			return "member/join";
		}// try-catch
		
		return "redirecr:/";
	}

	@ResponseBody
	@PostMapping("/nickCheck")
	public String NickCheck(@RequestBody String member_nick) throws Exception {
		logger.info("memberNick= " + member_nick);
		Integer result = memberService.checkNick(member_nick);
		logger.info("nickCheck result= " + result);

		return String.valueOf(result);
	}

	@ResponseBody
	@PostMapping("/idCheck")
	public String IdCheck(@RequestBody String member_id) throws Exception {
		logger.info("memberId= " + member_id);
		Integer result = memberService.checkID(member_id);
		logger.info("idCheck result= " + result);

		return String.valueOf(result);
	}

	@ResponseBody
	@PostMapping("/emailCheck")
	public String EmailCheck(@RequestBody String member_email) throws Exception {
		logger.info("memberEmail= " + member_email);
		Integer result = memberService.checkEmail(member_email);
		logger.info("emailCheck result= " + result);

		return String.valueOf(result);
	}

	@ResponseBody
	@GetMapping("/emailCheck")
	public int sendMailTest(String member_email, String randomPassword) throws Exception {

		logger.info("이메일 데이터 전송 확인");
		logger.info("인증번호 : " + member_email);
	
		Random random = new Random();
		int checkNum = random.nextInt(888888) + 111111;
		int result = 0;
		logger.info("인증번호 " + checkNum);
	
		String subject = "인증번호가 발급되었습니다."; // 제목
		String content = "<p>안녕하세요 고객님!<br><br>발급된 인증 번호는<br><br>" + checkNum + "<br><br>입니다.<br>해당 인증번호를 인증번호 확인란에 기입하여 주세요.</p>"; // 본문
		String from = "ehd1530@gmail.com"; // 보내는사람 이메일주소
		String to = member_email;
	
		try {
			MimeMessage mail = mailSender.createMimeMessage();
			MimeMessageHelper mailHelper = new MimeMessageHelper(mail,true ,"utf-8");
	
			mailHelper.setFrom(from);
			mailHelper.setTo(to);
			mailHelper.setSubject(subject);
			mailHelper.setText(content, true);
			// html태그를 사용하려면 true
			mailSender.send(mail);

			return checkNum; // 전송 정상적으로 처리됨
		} catch (Exception e) {
			e.printStackTrace();
			return result;
		}
	} // end sendMailTest()

}
