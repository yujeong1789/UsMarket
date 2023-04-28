package com.spring.usMarket.controller;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.usMarket.domain.member.MemberDto;
import com.spring.usMarket.service.member.MemberService;
import com.spring.usMarket.utils.ProfilePageHandler;
import com.spring.usMarket.utils.ProfileSearchCondition;

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
		Object userNo = request.getSession().getAttribute("userNo");
		String uri = request.getHeader("Referer");

		if(userNo != null) {
			if(request.getSession().getAttribute("prevPage") != null) {
				return "redirect:" + request.getSession().getAttribute("prevPage");
			}else {
				return "redirect:/";
			}
		}
		
		if (uri != null && !uri.contains("/login")) {
			request.getSession().setAttribute("prevPage", uri);
		} else {
			request.getSession().setAttribute("prevPage", null);
		}
		
		logger.info("referer = {}", uri);
		
		return "member/login";
	}
	
	@PostMapping("/login")
	public String loginCheck(HttpServletRequest request, String member_id, String member_password, 
			Model model,RedirectAttributes ratt) throws Exception {
		HttpSession session = request.getSession(true);
		String prevPage = (String) session.getAttribute("prevPage");

		if (prevPage != null && prevPage.endsWith("/join")) {
			prevPage += "?mode=modify";
		} else {
			prevPage = "/";
		}

		logger.info("ID 입력 정보 = {}, PW 입력 정보 = {}", member_id, member_password);

		Map<String, Object> member = memberService.loginCheckID(member_id);
		logger.info("회원정보 = {}", member);

		if (member == null || !new BCryptPasswordEncoder().matches(member_password, (String) member.get("MEMBER_PASSWORD"))) {
			logger.info("아이디 또는 비밀번호 오류");
			String msg = "아이디 또는 비밀번호를 잘못 입력했습니다.";
			model.addAttribute("msg", msg);
			model.addAttribute("mem_id", member_id);
			model.addAttribute("mem_pw", member_password);
			
			return "member/login";
		}

		logger.info("로그인 성공");
		if (member_password.length() == 6) {
			ratt.addFlashAttribute("loginMember", member);
			
			return "redirect:/member/join?mode=uppw";
		}

		session.setAttribute("userId", member_id);
		session.setAttribute("userNo", member.get("MEMBER_NO"));
		logger.info("prevPage = {}", prevPage);
		
		return "redirect:" + prevPage;
	}

	@GetMapping("/logout")
	public String logout(HttpServletRequest request) {
		String referer = request.getHeader("Referer");
		
		if (referer == null || referer.endsWith("modify") || referer.endsWith("mypage")) {
			referer = "/";
		}

		request.getSession().removeAttribute("userId");
		request.getSession().removeAttribute("userNo");
		logger.info("로그아웃 성공");
		
		return "redirect:" + referer;
	}

	@GetMapping("/search")
	public String search(HttpServletRequest request, Model model) {
		Object memberInfo = request.getSession().getAttribute("userId");
		
		model.addAttribute("memberInfo", memberInfo);
		model.addAttribute("mode", request.getParameter("mode"));
		
		return "member/search";
	}

	@PostMapping("/search")
	public String result(@RequestBody Map<String, Object> sc, RedirectAttributes ratt) {
		logger.info("@RequestBody= {}",sc);
		
		Map<String, Object> result = memberService.searchMember(sc);
		if(result == null) {
			ratt.addFlashAttribute("message", "없는 회원 정보입니다.");    
	    }
		logger.info("result= {}",result);
		ratt.addFlashAttribute("category","search");
		ratt.addFlashAttribute("result", result);
		
		return "redirect:/member/viewajax";
	}
	
	@PostMapping("/newpw")
	public String newpw(@RequestBody Map<String, Object> sc, RedirectAttributes ratt) {
		logger.info("@RequestBody= {}",sc);
		
		Map<String, Object>search = memberService.searchMember(sc);
		if (search == null) {
			ratt.addFlashAttribute("category","newPw");
			ratt.addFlashAttribute("result",null);
			
			return "redirect:/member/viewajax";
		}
		
		Random random = new Random();
		int checkNum = random.nextInt(888888) + 111111;
		logger.info("인증번호 " + checkNum);
	
		String subject = "임시 비밀번호가 발급되었습니다."; // 제목
		String content = "<p>안녕하세요 고객님!<br><br>발급된 임시 비밀번호는<br><br>" 
				+ checkNum + 
				"<br><br>입니다.<br>해당 비밀번호를 이용하여 로그인 후 비밀번호를 재설정 해주세요.</p>"; // 본문
		String from = "ehd1530@gmail.com"; // 보내는사람 이메일주소
		String to = (String) search.get("MEMBER_EMAIL");
	
		try {
			MimeMessage mail = mailSender.createMimeMessage();
			MimeMessageHelper mailHelper = new MimeMessageHelper(mail,true ,"utf-8");
	
			mailHelper.setFrom(from);
			mailHelper.setTo(to);
			mailHelper.setSubject(subject);
			mailHelper.setText(content, true);
			// html태그를 사용하려면 true
			mailSender.send(mail);

			Map<String,Object> searchPw = new HashMap<String,Object>();
			searchPw.put("member_password", String.valueOf(checkNum));
			searchPw.put("member_no", ((BigDecimal) search.get("MEMBER_NO")).intValue());
			logger.info("searchPw = {}",searchPw);
			memberService.resetMember(searchPw);
			
			ratt.addFlashAttribute("category","newPw");
			ratt.addFlashAttribute("result", checkNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/member/viewajax";
	}
	
	@PostMapping(value="/newlogin")
	public String updatePw(HttpServletRequest request,Model model) {
		HttpSession httpSession = request.getSession(true);
		Map<String, Object> member = new HashMap<String, Object>();
		
		logger.info("재설정 정보 = [member_no = {}, member_id = {}, member_password = {}", 
				request.getParameter("member_no"), request.getParameter("member_id"), request.getParameter("member_password"));

		member.put("member_no", Integer.parseInt(request.getParameter("member_no")));
		member.put("member_password", request.getParameter("member_password"));

		int result = memberService.resetMember(member);
		logger.info("result = {}", result);
		
		httpSession.setAttribute("userId", request.getParameter("member_id"));
		httpSession.setAttribute("userNo", request.getParameter("member_no"));
		
		logger.info("prevPage = {}",request.getSession().getAttribute("prevPage"));
		
		return "redirect:/";
	}
	
	@GetMapping("/join")
	public String join(HttpServletRequest request, Model model) {
		MemberDto memberInfo = null;
	    String member_no = null;
		String mode = "join";
			    
	    if (request.getSession().getAttribute("userNo") != null) {
	    	member_no = String.valueOf(request.getSession().getAttribute("userNo"));
			mode = "modify";
		}
	    
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
	        model.addAttribute("member", request.getParameter("member"));
	    } catch (Exception e) {
	        e.printStackTrace();
	    }

	    return "member/join";
	}

	@PostMapping("/join")
	public String join(@ModelAttribute MemberDto member,MultipartHttpServletRequest request,Model model) {
		Object prevPage = request.getSession().getAttribute("prevPage");

		if(request.getSession().getAttribute("prevPage") == null) {
			prevPage = "/";
		}
		
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
		
		return "redirect:" + prevPage;
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
	public String info(HttpServletRequest request, Model model, ProfileSearchCondition sc) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy년 MM월 dd일");
		try {
			String member_no = String.valueOf(request.getSession().getAttribute("userNo"));
			logger.info("member_id = {}, member_no = {}", request.getSession().getAttribute("userId").toString(), member_no);

			if (request.getParameter("member_no") != null) {
		    	member_no = request.getParameter("member_no");
				List<Map<String, Object>> productStateCnt= memberService.getProductStateCnt(member_no);
				logger.info("제품 상태별 갯수 = {}",productStateCnt);
				
				model.addAttribute("stateCnt", productStateCnt);
		    }
			
			MemberDto memberInfo = memberService.getMemberInfo(member_no);// 회원정보
			
			sc.setMember_no(member_no);
			sc.setPageSize(15);		
			
			List<Map<String, Object>> mypageProductList = memberService.getProduct(sc);//제품정보
			
			int productCnt = memberService.getProductCnt(member_no, sc.getCondition());// 제품 전체 수
			int bookmarkCnt = memberService.getBookmarkCnt(member_no,sc.getCondition());// 찜 전체 수
			int reviewCnt = memberService.getReviewCnt(member_no, sc.getCondition());// 리뷰 전체 수
			
			int totalCnt = productCnt;
			ProfilePageHandler pageHandler = new ProfilePageHandler(totalCnt, sc);

			model.addAttribute("category", "productList");
			model.addAttribute("memberInfo", memberInfo);
			model.addAttribute("regdate",dateFormat.format(memberInfo.getMember_regdate()));
			model.addAttribute("mypageList", mypageProductList);
			model.addAttribute("product", productCnt);
			model.addAttribute("review", reviewCnt);
			model.addAttribute("bookmark", bookmarkCnt);
			model.addAttribute("Page", sc.getPage());
			model.addAttribute("PageSize", sc.getPageSize());
			model.addAttribute("ph", pageHandler);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "member/mypage";
	}
	
	@PostMapping("/mypage")
	public String reinfo(@RequestBody ProfileSearchCondition sc, RedirectAttributes ratt) {
		sc.setPageSize(15);
		logger.info("(post)ProfileSC = {}", sc.toString());
		
		List<Map<String, Object>> myList = new ArrayList<>();
		int totalCnt = 0;
		String category = null;
		
		try {
			if(sc.getMode().equals("productList")) {
				myList = memberService.getProduct(sc);
				totalCnt = memberService.getProductCnt(sc.getMember_no(), sc.getCondition());
				category = "productList";
			}
			if(sc.getMode().equals("reviewList")) {
				sc.setPageSize(5);
				myList = memberService.getReview(sc);
				totalCnt = memberService.getReviewCnt(sc.getMember_no(), sc.getCondition());
				category = "reviewList";
			}
			if(sc.getMode().equals("bookmarkList")) {
				myList = memberService.getBookmark(sc);
				totalCnt = memberService.getBookmarkCnt(sc.getMember_no(), sc.getCondition());
				category = "bookmarkList";
			}
			
			logger.info("totalCnt = {}, myList = {}, sc.setPageSize({})", totalCnt, myList,sc.getPageSize());
			
			ProfilePageHandler pageHandler = new ProfilePageHandler(totalCnt, sc);
	
			ratt.addFlashAttribute("category", category);
			ratt.addFlashAttribute("pageList", myList);
			ratt.addFlashAttribute("page", sc.getPage());
			ratt.addFlashAttribute("pageSize", sc.getPageSize());
			ratt.addFlashAttribute("condition", sc.getCondition());
			ratt.addFlashAttribute("order", sc.getOrder());
			ratt.addFlashAttribute("ph", pageHandler);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/member/viewajax";
	}
	
	@GetMapping("/viewajax")
	public void listform() throws Exception{
		logger.info("viewajax");
	}

	@PostMapping("/myProductList")
	public String MyProductList(@RequestBody ProfileSearchCondition sc, RedirectAttributes ratt) throws Exception {
		sc.setPageSize(15);
		int totalCnt = 0;
		
		logger.info("member_no = {}", sc.getMember_no());
		
		List<Map<String, Object>> productList = memberService.getProduct(sc);
		logger.info("내 상품 리스트 = " + productList);
		
		totalCnt = memberService.getProductCnt(sc.getMember_no(), sc.getCondition());
		
		ProfilePageHandler pageHandler = new ProfilePageHandler(totalCnt, sc);
		
		ratt.addFlashAttribute("category", "productList");
		ratt.addFlashAttribute("pageList", productList);
		ratt.addFlashAttribute("page", sc.getPage());
		ratt.addFlashAttribute("pageSize", sc.getPageSize());
		ratt.addFlashAttribute("ph", pageHandler);
		
		return "redirect:/member/viewajax";
	}

	@PostMapping("/myBookmark")
	public String MyBookmark(@RequestBody ProfileSearchCondition sc, RedirectAttributes ratt) throws Exception {
		sc.setPageSize(15);
		int totalCnt = 0;
		
		logger.info("RequestBody = {}", sc.toString());
		
		List<Map<String, Object>> bookmarkList = memberService.getBookmark(sc);
		logger.info("북마크 리스트 = {}", bookmarkList);
		
		totalCnt = memberService.getBookmarkCnt(sc.getMember_no(),sc.getCondition());//Mypage_Bookmark
		
		ProfilePageHandler pageHandler = new ProfilePageHandler(totalCnt, sc);
		
		ratt.addFlashAttribute("category", "bookmarkList");
		ratt.addFlashAttribute("pageList", bookmarkList);
		ratt.addFlashAttribute("page", sc.getPage());
		ratt.addFlashAttribute("pageSize", sc.getPageSize());
		ratt.addFlashAttribute("ph", pageHandler);
		
		return "redirect:/member/viewajax";
	}
	
	@PostMapping("/myReview")
	public String MyReview(@RequestBody ProfileSearchCondition sc, RedirectAttributes ratt) throws Exception {
		sc.setPageSize(5);
		int totalCnt = 0;
		
		logger.info("member_no = {}", sc.getMember_no());
		
		List<Map<String, Object>> reviewList = memberService.getReview(sc);
		logger.info("후기 리스트 = " + reviewList);
		
		totalCnt = memberService.getReviewCnt(sc.getMember_no(), sc.getCondition());
		ProfilePageHandler pageHandler = new ProfilePageHandler(totalCnt, sc);
		
		ratt.addFlashAttribute("category", "reviewList");
		ratt.addFlashAttribute("pageList", reviewList);
		ratt.addFlashAttribute("page", sc.getPage());
		ratt.addFlashAttribute("pageSize", sc.getPageSize());
		ratt.addFlashAttribute("ph", pageHandler);
		
		return "redirect:/member/viewajax";
	}
	
	@ResponseBody
	@PostMapping(value = "/nickCheck", produces = "application/text; charset=utf8")
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
		logger.info("memberEmail = " + member_email);
		String result = memberService.checkEmail(member_email);
		logger.info("emailCheck result = " + result);

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
	}
}
