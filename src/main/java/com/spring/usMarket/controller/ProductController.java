package com.spring.usMarket.controller;

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
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.spring.usMarket.domain.product.ProductCategoryDto;
import com.spring.usMarket.domain.product.ProductDto;
import com.spring.usMarket.domain.product.ProductFileDto;
import com.spring.usMarket.domain.product.ProductInsertDto;
import com.spring.usMarket.service.product.ProductFileService;
import com.spring.usMarket.service.product.ProductService;
import com.spring.usMarket.utils.PageHandler;
import com.spring.usMarket.utils.SearchCondition;
import com.spring.usMarket.utils.SessionParameters;

@Controller
@RequestMapping("/product")
public class ProductController {
	private static final Logger logger = LoggerFactory.getLogger(ProductController.class);
	
	private static final int ADDED = 1;
	private static final int NOT_ADDED = 0;
	
	@Autowired
	ProductService productService;
	
	@Autowired
	ProductFileService fileService;
	
	@GetMapping("/list")
	public void list(SearchCondition sc, Model model){
		sc.setPageSize(30);
		logger.info("queryString = "+sc.getQueryString(sc.getPage()));
		
		try {
			if(sc.getKeyword() == null || sc.getKeyword() == "") {
				// 검색 아닐시 하위 카테고리 출력
				List<ProductCategoryDto>categoryList2 = productService.getProductCategory2(sc.getCategory1());
				String category1_name = categoryList2.get(0).getProduct_category1_name();
				
				model.addAttribute("categoryList2", categoryList2);
				model.addAttribute("category1_name", category1_name);
			} // if
			
			List<ProductDto> productList = productService.getProductByCategory(sc);
			int totalCnt = productService.getProductCount(sc);
			
			PageHandler pageHandler = new PageHandler(totalCnt, sc);
			
			model.addAttribute("productList", productList);
			model.addAttribute("page", sc.getPage());
			model.addAttribute("pageSize", sc.getPageSize());
			model.addAttribute("ph", pageHandler);
			
		} catch (Exception e) {
			e.printStackTrace();
		} // try-catch
	}
	
	
	@GetMapping("/info")
	public void info(String product_no, HttpServletRequest request, Model model) {
		try {
			Map<String, Object> productInfo = productService.getProductInfo(product_no);
			
			List<String> productImage = productService.getProductImage(product_no);
			ObjectMapper mapper = new ObjectMapper();
			String jsonText = mapper.writeValueAsString(productImage);
			
			model.addAttribute("jsonText", jsonText);
			model.addAttribute("productInfo", productInfo); // 기존 - 2691ms
			
			int bookmarkStatus = 0;
			if(request.getSession().getAttribute("userNo") != null) {
				Integer member_no = Integer.parseInt(SessionParameters.getUserNo(request));
				bookmarkStatus = productService.getBookmarkByInfo(member_no+product_no);
			}
			
			model.addAttribute("bookmarkStatus", bookmarkStatus);
			
		} catch (Exception e) {
			e.printStackTrace();
		} // try-catch
	}
	
	
	@GetMapping("/sell")
	public void sell(){
		logger.info("product/sell");
	}
	
	
	@PostMapping("/sell")
	public String addProduct(MultipartHttpServletRequest request, ProductInsertDto dto){
		dto.setSeller_no(Integer.parseInt(SessionParameters.getUserNo(request)));
		try {
			// 1. 상품 등록
			logger.info("productInsertDto = {}", dto.toString());
			int result = productService.addProduct(dto);
			
			if(result != 1) return "redirect:/product/sell";
			
			// 2. 파일 업로드
			List<ProductFileDto> list = fileService.upload(request.getFiles("product_img"), dto.getProduct_no());
			
			// 3. 파일 db에 insert
			int rowCnt = productService.addProductFile(list);
			logger.info("addProductFile {}", (list.size() == rowCnt ? "SUCCESS" : "FAIL"));
			
		} catch (Exception e) {
			e.printStackTrace();
		} // try-catch
				
		return "redirect:/product/info?product_no="+dto.getProduct_no();
	}
	
	
	/*
	 * 상품 delete할 시 자식 테이블에 영향이 있음. 따라서 db상에서 삭제처리하지 않고 blind 상태코드를 추가해 update하는 식으로 구현할 것.
	 * */
	@PostMapping("/remove")
	public String removeProduct(HttpServletRequest request, String product_no, Integer product_state_no) {
		String seller_no = SessionParameters.getUserNo(request);
		
		logger.info("product_no = {}, seller_no = {}, product_state_no = {}", product_no, seller_no, product_state_no);
		
		String url = "redirect:/product/info?product_no="+product_no;
		
		try {
			List<String> productImage = productService.getProductImage(product_no);
			boolean deleteResult = fileService.delete(productImage);
			if(deleteResult) {
				
				int updateCnt = productService.modifyProductState(4, seller_no, product_no);
				int removeCnt = productService.removeProductImage(product_no);
				
				if(updateCnt+removeCnt == productImage.size()+1) {
					url = "redirect:/";
					logger.info("removeProduct SUCCESS");
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return url;
	}
	

	@PostMapping("/buy")
	public void buy(String product_no, HttpServletRequest request, Model model) {
		String customer_no = SessionParameters.getUserNo(request);
		
		logger.info("buy product_no = {}, customer_no = {}", product_no, customer_no);
		try {
			Map<String, Object> productOrderInfo = productService.getProductOrderInfo(product_no);
			
			model.addAttribute("product_no", product_no);
			model.addAttribute("customer_no", customer_no);
			model.addAttribute("productOrderInfo", productOrderInfo);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

}
