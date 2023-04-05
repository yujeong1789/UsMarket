package com.spring.usMarket.controller;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
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
import com.spring.usMarket.domain.product.ProductDto;
import com.spring.usMarket.service.member.MemberService;
import com.spring.usMarket.utils.PageHandler;
import com.spring.usMarket.utils.SearchCondition;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/member")
@RequiredArgsConstructor
public class MemberController {
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);

	private final MemberService memberService;
	private final JavaMailSender mailSender;

	@GetMapping("/login")
	public String login(HttpServletRequest request) {
		String uri = request.getHeader("Referer");
		if (uri != null & !uri.contains("/login")) {
			request.getSession().setAttribute("prevPage", uri);
		}
		return "member/login";
	}

	@PostMapping("/login")
	public String loginCheck(HttpServletRequest request, String member_id, String member_password, Model model)
			throws Exception {
		BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
		Map<String, Object> member = memberService.loginCheckID(member_id);
		HttpSession httpSession = request.getSession(true);
		Object result= null;

		String prevPage = (String)request.getSession().getAttribute("prevPage");
		
		logger.info("ID 입력 정보 = " + member_id + ", PW 입력 정보 = " + member_password);
		logger.info("회원정보 = " + member);
		
		if(prevPage.substring(prevPage.length()-4, prevPage.length()).equals("join")){
			result = request.getSession().getAttribute("prevPage")+"?mode=modify";
		}else if(request.getSession().getAttribute("prevPage") != null){
			result = request.getSession().getAttribute("prevPage");			
		}else {
			result = "/";
		}
		
		if (member == null) {
			logger.info("아이디 없음");
			String msg = "잘못된 입력입니다.";
			model.addAttribute("msg", msg);
			model.addAttribute("mem_id", member_id);
			model.addAttribute("mem_pw", member_password);
			return "member/login";
		} else if (encoder.matches(member_password, (String) member.get("MEMBER_PASSWORD"))) {
			logger.info("로그인 성공");
			httpSession.setAttribute("userId", member_id);
			httpSession.setAttribute("userNo", member.get("MEMBER_NO"));
			logger.info("result = "+result);
			return "redirect:"+result;
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
		String referer = request.getHeader("Referer");
		
		request.getSession().removeAttribute("userId");
		request.getSession().removeAttribute("userNo");
		logger.info("로그아웃 {}", (request.getSession().getAttribute("userId") == null && 
				request.getSession().getAttribute("userNo") == null ? "성공" : "실패"));
		
		logger.info("referer.substring = "+referer.substring(referer.length()-6, referer.length()));
		
		if(referer.substring(referer.length()-6, referer.length()).equals("modify") ||
				referer.substring(referer.length()-6, referer.length()).equals("mypage")) {
			referer = "/";
		};
		return "redirect:" + referer;
	}

	@GetMapping("/join")
	public String join(HttpServletRequest request, Model model) {
		String member_no = null;
		if (request.getSession().getAttribute("userNo") != null) {
			BigDecimal memNo= (BigDecimal) request.getSession().getAttribute("userNo");
			member_no = memNo.toString();
		}
	    MemberDto memberInfo = null;
	    String mode = "join";

	    try {
	        if (request.getParameter("mode") != null) {
	            mode = request.getParameter("mode");
	        }

	        if (member_no != null) {
	            memberInfo = memberService.getMemberInfo(member_no);//Mypage_member
	            logger.info("memberInfo = {}", memberInfo);
	            model.addAttribute("memberInfo", memberInfo);
	        }
	        logger.info(mode);
	        model.addAttribute("mode", mode);
	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return "member/join";
	}

	@PostMapping("/join")
	public String join(@ModelAttribute MemberDto member,MultipartHttpServletRequest request,Model model) {
		try {
			// 1. 파일 업로드
			String img = "/resources/customer/img/default_profile.png";
			if(request.getFile("member_profile_image").getSize() != 0) {
				img = memberService.upload(request.getFile("member_profile_image"));
			}

			// 2. 회원 등록
			member.setMember_image(img);
			logger.info("memberDto = {}",member.toString());
			int result = memberService.addMember(member);
			if(result != 1) {
				model.addAttribute("message", "이미 등록된 회원정보입니다.");
				return "redirect:/member/join";
			}
		} catch (Exception e) {
			model.addAttribute("message", "회원가입에 실패 했습니다.");
			e.printStackTrace();
			return "member/join";
		}// try-catch
		return "redirect:" + request.getSession().getAttribute("prevPage");
	}

	@PostMapping("/modify")
	public String modify(@ModelAttribute MemberDto member,MultipartHttpServletRequest request,Model model) {
		String img=null;
		
		try {
			if(request.getFile("member_profile_image").getSize() != 0) {
				img = memberService.upload(request.getFile("member_profile_image"));
				member.setMember_image(img);
			}
			
			// 1. 회원 정보 변경
			logger.info("memberDto = {}",member.toString());
			int result = memberService.modifyMember(member);
			if(result != 1) {
				model.addAttribute("message", "빈칸을 확인해 주세요.");
				return "redirect:/member/join?mode=modify";
			}
		} catch (Exception e) {
			model.addAttribute("message", "정보 변경에 실패하였습니다.");
			e.printStackTrace();
			return "member/join?mode=modify";
		}// try-catch
		return "redirect:/member/mypage";
	}
	
	@GetMapping("/mypage")
	public String info(HttpServletRequest request, Model model, SearchCondition sc) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy년 MM월 dd일");
		
		String member_no = String.valueOf(request.getSession().getAttribute("userNo"));
		logger.info("member_id = {}, member_no = {}", request.getSession().getAttribute("userId").toString(), member_no);
		//session으로 넘어온 회원 정보

		int totalCnt = 0;
		sc.setPageSize(15);		

		try {
			String memberNo = member_no;
		    if (request.getParameter("member_no") != null) {
		    	memberNo = request.getParameter("member_no");
		    }
			MemberDto memberInfo = memberService.getMemberInfo(memberNo);//Mypage_member

			List<Map<String, Object>> mypageProductList = memberService.getMypageProduct(memberNo);
			int ProductCount = memberService.getMypageProductCount(memberNo);//Mypage_product

			int bookmarkCount = memberService.getMypageBookmarkCount(memberNo);//Mypage_Bookmark

			PageHandler pageHandler = new PageHandler(totalCnt, sc);

			model.addAttribute("deNo", 211);
			
			model.addAttribute("memberInfo", memberInfo);
			model.addAttribute("regdate",dateFormat.format(memberInfo.getMember_regdate()));
			model.addAttribute("mypageList", mypageProductList);
			model.addAttribute("product", ProductCount);
			model.addAttribute("bookmark", bookmarkCount);
			model.addAttribute("Page", sc.getPage());
			model.addAttribute("PageSize", sc.getPageSize());
			model.addAttribute("ph", pageHandler);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "member/mypage";
	}
	
	@PostMapping("/MyBookmark")
	public String MyBookmark(@RequestBody String member_no, Model model, SearchCondition sc) throws Exception {
		sc.setPageSize(15);
		int totalCnt = 0;
		
		logger.info("member_No = {}", member_no);
		
		List<Map<String, Object>> mypageBookmarkList = memberService.getMypageBookmark(member_no);
		logger.info("북마크 리스트 = " + mypageBookmarkList);
		totalCnt = mypageBookmarkList.size();
		PageHandler pageHandler = new PageHandler(totalCnt, sc);
		
		model.addAttribute("MyList", "MyBookmark");
		model.addAttribute("mypageList", mypageBookmarkList);
		model.addAttribute("Page", sc.getPage());
		model.addAttribute("PageSize", sc.getPageSize());
		model.addAttribute("ph", pageHandler);
		
		return "member/viewajax";
	}

	@PostMapping("/MyProductList")
	public String MyProductList(@RequestBody String member_no, Model model, SearchCondition sc) throws Exception {
		sc.setPageSize(15);
		int totalCnt = 0;
		
		logger.info("member_No = {}", member_no);
		
		List<Map<String, Object>> mypageProductList = memberService.getMypageProduct(member_no);
		logger.info("마이페이지 상품 리스트 = " + mypageProductList);
		totalCnt = mypageProductList.size();
		PageHandler pageHandler = new PageHandler(totalCnt, sc);
		
		model.addAttribute("MyList", "MyProductList");
		model.addAttribute("mypageList", mypageProductList);
		model.addAttribute("Page", sc.getPage());
		model.addAttribute("PageSize", sc.getPageSize());
		model.addAttribute("ph", pageHandler);
		
		return "member/viewajax";
	}
	
	@GetMapping("/transactionhistory")
	public String transactionhistory(HttpServletRequest request) {
		return "member/transactionhistory";
	}
	
	@ResponseBody
	@PostMapping("/nickCheck")
	public String NickCheck(@RequestBody String member_nick) throws Exception {
		logger.info("memberNick= " + member_nick);
		String result = memberService.checkNick(member_nick);
		logger.info("checkNick / result= " + result);

		return result;
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
		String result = memberService.checkEmail(member_email);
		logger.info("emailCheck result= " + result);

		return result;
	}

	@ResponseBody
	@PostMapping("/sendEmail")
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
