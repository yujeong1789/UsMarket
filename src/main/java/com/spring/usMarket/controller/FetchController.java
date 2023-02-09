package com.spring.usMarket.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.spring.usMarket.domain.chat.ChatDto;
import com.spring.usMarket.domain.deal.DealInsertDto;
import com.spring.usMarket.service.chat.ChatService;
import com.spring.usMarket.service.deal.DealService;
import com.spring.usMarket.service.product.ProductService;

@RestController
@RequestMapping("/fetch")
public class FetchController {
	private static final Logger logger = LoggerFactory.getLogger(FetchController.class);
	
	@Autowired
	ProductService productService;
	
	@Autowired
	DealService dealService;
	
	@Autowired
	ChatService chatService;
	
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
	
	@GetMapping("/bookmark/{current_no}/{product_no}")
	public int bookmark(@PathVariable Integer current_no, @PathVariable String product_no) {
		
		int bookmarkStatus = 0;
		
		try {
			bookmarkStatus = productService.getBookmarkByInfo(current_no, product_no);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
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
	
	@GetMapping(value="/nickname/{member_no}", produces="text/plain; charset=UTF-8")
	public String nickName(@PathVariable String member_no) {
		logger.info("member_no = {}", member_no);
		
		String nickName = "";
		
		try {
			Integer member_no_ = Integer.parseInt(member_no);
			nickName = chatService.getNickName(member_no_);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return nickName;
	}
	
	@GetMapping("/chatlist/{member_no}")
	public List<Map<String, Object>> chatList(@PathVariable String member_no) {
		logger.info("member_no = {}", member_no);
		
		List<Map<String, Object>> chatList = new ArrayList<>();
		try {
			Integer member_no_ = Integer.parseInt(member_no);
			chatList = chatService.getChatList(member_no_);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return chatList;
	}
	
	@GetMapping("/chatinfo/{room_no}")
	public List<ChatDto> chatInfo(@PathVariable String room_no) {
		logger.info("room_no = {}", room_no);
		
		List<ChatDto> chatInfo = new ArrayList<>();
		try {
			chatInfo = chatService.getChatInfo(room_no);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return chatInfo;
	}
}
