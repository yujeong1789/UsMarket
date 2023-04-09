package com.spring.usMarket.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.spring.usMarket.domain.chat.ChatDto;
import com.spring.usMarket.domain.deal.DealInsertDto;
import com.spring.usMarket.domain.qna.QnaInsertDto;
import com.spring.usMarket.domain.report.ReportInsertDto;
import com.spring.usMarket.service.chat.ChatService;
import com.spring.usMarket.service.deal.DealService;
import com.spring.usMarket.service.product.ProductService;
import com.spring.usMarket.service.qna.QnaService;
import com.spring.usMarket.service.report.ReportService;
import com.spring.usMarket.utils.SessionParameters;
import com.spring.usMarket.utils.SingleFileService;

@RestController
@RequestMapping("/fetch")
public class FetchController {
	private static final Logger logger = LoggerFactory.getLogger(FetchController.class);
	
	private static final String NOT_ADDED = "0";
	private static final String ADDED = "1";
	
	@Autowired ProductService productService;
	@Autowired DealService dealService;
	@Autowired ChatService chatService;
	@Autowired ReportService reportService;
	@Autowired SingleFileService fileService;
	@Autowired QnaService qnaService;
	
	@PostMapping("/sessionCheck")
	public String sessionCheck(HttpServletRequest request) {
		String userNo = SessionParameters.getUserNo(request);
		
		return userNo;
	}
	
	@GetMapping("/category")
	public List<Map<String, Object>> category(){
		
		List<Map<String, Object>> allCategory = new ArrayList<>();
		
		try {
			allCategory = productService.getProductCategory1();
		} catch (Exception e) {
			e.printStackTrace();
		} // try-catch
		
		return allCategory;
	}
	
	@GetMapping("/category2/{category2}")
	public List<Map<String, Object>> category2(@PathVariable Integer category2){
		
		List<Map<String, Object>> category = new ArrayList<>();
		
		try {
			category = productService.getCategory2(category2);
		} catch (Exception e) {
			e.printStackTrace();
		} // try-catch
		
		return category;
	}
	
	
	@GetMapping("/seller/{seller_no}")
	public Map<String, Object> seller(@PathVariable Integer seller_no){
		
		Map<String, Object> sellerInfo = new HashMap<>();
		
		try {
			sellerInfo = productService.getSellerInfo(seller_no);
		} catch (Exception e) {
			e.printStackTrace();
		} // try-catch
		
		return sellerInfo;
	}
	
	
	@GetMapping("/topReview/{seller_no}")
	public List<Map<String, Object>> topReview(@PathVariable Integer seller_no){
		
		List<Map<String, Object>> topReview = new ArrayList<>();
		
		try {
			topReview = productService.getReviewByInfo(seller_no);
		} catch (Exception e) {
			e.printStackTrace();
		} // try-catch
		
		return topReview;
	}
	
	
	@GetMapping("/bookmark/{product_no}/{bookmarkStatus}")
	public String bookmark(@PathVariable String product_no, @PathVariable String bookmarkStatus, HttpServletRequest request) {
		
		Integer member_no = Integer.parseInt(String.valueOf(request.getSession().getAttribute("userNo")));
		int rowCnt = 0;
		
		try {
			if(bookmarkStatus.equals(ADDED) || bookmarkStatus == ADDED) {
				rowCnt = productService.removeBookmark(member_no+product_no);
				bookmarkStatus = NOT_ADDED;
			} else if(bookmarkStatus.equals(NOT_ADDED) || bookmarkStatus == NOT_ADDED) {
				rowCnt = productService.addBookmark(member_no, product_no);
				bookmarkStatus = ADDED;
			}
			if(rowCnt == 0) throw new Exception();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		logger.info("after bookmarkStatus = {}, bookmark result = {}", (bookmarkStatus == ADDED ? "ADDED" : "NOT_ADDED"), (rowCnt == 1 ? "OK" : "FAIL"));
		
		return bookmarkStatus;
	}
	
	@GetMapping("/customerInfo/{customer_no}")
	public Map<String, Object> customerInfo(@PathVariable String customer_no) {
		
		Map<String, Object> customerInfo = new HashMap<>();
		
		try {
			customerInfo = productService.getCustomerInfo(customer_no);
		} catch (Exception e) {
			e.printStackTrace();
		} // try-catch
		
		return customerInfo;
	}
	
	
	@PostMapping("/deal/add/{isUpdate}")
	public String dealAdd(@RequestBody DealInsertDto dto, @PathVariable String isUpdate) {
		logger.info("isUpdate = {}", isUpdate);
		logger.info("DealInsertDto = {}", dto.toString());

		String deal_no = "";
		
		try {
			boolean result = dealService.addDeal(dto, isUpdate);
			if(result) deal_no = dto.getDeal_no();
			logger.info("deal_no = {}", deal_no);
		} catch (Exception e) {
			e.printStackTrace();
		} // try-catch

		return deal_no;
	}
	
	
	@GetMapping(value="/chatmember/{member_no}")
	public Map<String, Object> chatMember(@PathVariable String member_no) {
		logger.info("member_no = {}", member_no);
		
		Map<String, Object> memberMap = new HashMap<>();
		
		try {
			Integer member_no_ = Integer.parseInt(member_no);
			memberMap = chatService.getChatMember(member_no_);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return memberMap;
	}
	
	
	@GetMapping("/chatlist")
	public List<Map<String, Object>> chatList(HttpServletRequest request) {
		Integer member_no = Integer.parseInt(SessionParameters.getUserNo(request));
		logger.info("member_no = {}", member_no);
		
		List<Map<String, Object>> chatList = new ArrayList<>();
		try {
			chatList = chatService.getChatList(member_no);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return chatList;
	}
	
	
	@PostMapping("/chatinfo")
	public List<ChatDto> chatInfo(@RequestBody String room_no, HttpServletRequest request) {
		Integer chat_to = Integer.parseInt(SessionParameters.getUserNo(request));
		logger.info("room_no = {}, chat_to = {}", room_no, chat_to);
		
		List<ChatDto> chatInfo = new ArrayList<>();
		try {
			chatInfo = chatService.getChatInfo(room_no);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return chatInfo;
	}
	
	@SuppressWarnings("unchecked")
	@PostMapping("/chat/send")
	public Map<String, Object> chatSend(@RequestBody ChatDto dto, HttpServletRequest request) {
		dto.setChat_from(Integer.parseInt(SessionParameters.getUserNo(request)));
		dto.setChat_time(new Date());
		dto.setChat_read("N");
		
		logger.info(dto.toString());
		
		Map<String, Object> chatMap = new HashMap<>();
		try {
			int rowCnt = chatService.addChat(dto);
			
			if(rowCnt == 0) throw new Exception();
			ObjectMapper objectMapper = new ObjectMapper();
			chatMap = objectMapper.convertValue(dto, Map.class);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return chatMap;
	}
	
	@PostMapping("/chat/read")
	public int chatRead(@RequestBody String room_no, HttpServletRequest request) {
		Integer chat_to = Integer.parseInt(SessionParameters.getUserNo(request));
		logger.info("chatRead room_no = {}, member_no = {}", room_no, chat_to);
		int updateCnt = 0;
		try {
			updateCnt = chatService.modifyChatRead(room_no, chat_to);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return updateCnt;
	}
	
	@GetMapping("/reportCategory/{report_category1_no}")
	public List<Map<String, Object>> reportCategory(@PathVariable String report_category1_no){
		logger.info("report_category1_no = {}", report_category1_no);
		List<Map<String, Object>> reportCategoryMap = new ArrayList<>();
		
		try {
			reportCategoryMap = reportService.getReportCategory2(Integer.parseInt(report_category1_no));
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return reportCategoryMap;
	}
	
	@PostMapping(value="/report", produces="text/plain; charset=UTF-8")
	public String report(MultipartHttpServletRequest request, ReportInsertDto dto) {
		
		String result = "신고 등록에 실패했습니다.";
		dto.setReport_image("");
		
		// 이미지 업로드 작업
		try {
			if(request.getFile("image") != null) {
				String realPath = fileService.upload(request.getFile("image"), dto.getReport_no(), "report");
				dto.setReport_image(realPath);
			} // if
					
			dto.setMember_no(Integer.parseInt(SessionParameters.getUserNo(request)));
			logger.info("dto.toString() = {}", dto.toString());
			
			int rowCnt = reportService.addReport(dto);
			
			if(rowCnt == 1) result = "신고가 정상적으로 접수되었습니다.";
			
		} catch (Exception e) {
			e.printStackTrace();
		} // try-catch
		
		return result;
	}
	
	@GetMapping("/newchat")
	public int newChat(HttpServletRequest request) {
		
		Integer member_no = Integer.parseInt(SessionParameters.getUserNo(request));
		int result = 0;
		
		try {
			result = chatService.getNewChat(member_no);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
	@PostMapping(value="/qna/reg")
	public Map<String, Object> qnaReg(QnaInsertDto dto, MultipartHttpServletRequest request) {
		
		logger.info("QnaInsertDto = {}", dto.toString());
		String msg = "문의 등록에 실패했습니다.";
		Map<String, Object> resultMap = new HashMap<>();
		
		// 이미지 업로드 작업
		try {
			if(request.getFile("image") != null) {
				String realPath = fileService.upload(request.getFile("image"), dto.getQna_no(), "qna");
				dto.setQna_image(realPath);
			} // if
					
			dto.setMember_no(Integer.parseInt(SessionParameters.getUserNo(request)));
			logger.info("dto.toString() = {}", dto.toString());
			
			int rowCnt = qnaService.addQna(dto);
			
			if(rowCnt == 1) msg = "문의가 정상적으로 접수되었습니다.";
			
			resultMap.put("msg", msg);
			resultMap.put("qna_no", dto.getQna_no());
		} catch (Exception e) {
			e.printStackTrace();
		} // try-catch
		
		return resultMap;
	}
}
