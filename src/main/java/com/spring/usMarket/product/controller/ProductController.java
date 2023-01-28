package com.spring.usMarket.product.controller;

import java.util.List;
import java.util.Map;

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
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.spring.usMarket.common.PageHandler;
import com.spring.usMarket.common.SearchCondition;
import com.spring.usMarket.product.domain.ProductCategoryDto;
import com.spring.usMarket.product.domain.ProductDto;
import com.spring.usMarket.product.domain.ProductFileDto;
import com.spring.usMarket.product.domain.ProductInsertDto;
import com.spring.usMarket.product.service.ProductFileService;
import com.spring.usMarket.product.service.ProductService;

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
			model.addAttribute("productInfo", productInfo);
			
		} catch (Exception e) {
			e.printStackTrace();
		} // try-catch
	}
	
	
	@GetMapping("/buy")
	public void buy() {
		logger.info("product/buy");
	}
	
	
	@GetMapping("/like")
	public String like(HttpServletRequest request, String product_no, Integer status) {
		
		Integer member_no = Integer.parseInt(String.valueOf(request.getSession().getAttribute("userNo")));
		
		logger.info("like, member_id = {}, member_no = {}", request.getSession().getAttribute("userId").toString(), member_no);
		
		try {
			if(status == ADDED) {
				// 이미 북마크 추가된 상태면 삭제
				productService.removeBookmark(member_no, product_no);
			}else if(status == NOT_ADDED) {
				// 추가되지 않은 상태면 북마크 추가
				productService.addBookmark(member_no, product_no);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} // try-catch
		
		return "redirect:/product/info?product_no="+product_no;
	}
	
	
	@GetMapping("/sell")
	public void sell(){
		logger.info("product/sell");
	}
	
	
	@PostMapping("/sell")
	public String addProduct(MultipartHttpServletRequest request, ProductInsertDto dto){
		dto.setSeller_no(Integer.parseInt(getUserNo(request)));
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
		String seller_no = getUserNo(request);
		
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
	

    private String getUserNo(HttpServletRequest request) {
        // 1. 세션을 얻어서
        HttpSession session = request.getSession();
        // 2. 세션에 id가 있는지 확인, 있으면 true를 반환
        return String.valueOf(request.getSession().getAttribute("userNo"));
    }
}
