package com.usMarket.test;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertTrue;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.transaction.annotation.Transactional;

import com.spring.usMarket.domain.product.ProductCategoryDto;
import com.spring.usMarket.domain.product.ProductDto;
import com.spring.usMarket.domain.product.ProductInsertDto;
import com.spring.usMarket.service.product.ProductService;
import com.spring.usMarket.utils.SearchCondition;

@Transactional
@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class ProductServiceTest {
	
	private static int DUMMY_MEMBER_NO = 3;
	private static String RANDOM_CATEGORY_1 = String.valueOf((int)((Math.random()*15)+1)); // product_category1 범위 내 난수 생성
	
	@Autowired private ProductService productService;
	
	@Test
	public void getCategoryTest() throws Exception{
		List<Map<String, Object>> category1 = productService.getProductCategory1();
		assertEquals(category1.size(), 15);
		
		List<ProductCategoryDto> category2 = productService.getProductCategory2(RANDOM_CATEGORY_1);
		assertTrue(category2.size() != 0);
	}
	
	@Test
	public void setBookmarkTest() throws Exception{
		List<ProductDto> productList = productService.getProductByCategory(new SearchCondition(1, 30, "", "", "1", "1"));
		
		List<String> productNoList = new ArrayList<>();
		for (ProductDto dto : productList) {
			productNoList.add(dto.getProduct_no());
		}
		
		String randomProductNo = productNoList.get((int)((Math.random()*productNoList.size()))).toString();
		int bookmarkStatus = productService.getBookmarkByInfo(DUMMY_MEMBER_NO+randomProductNo);
		
		int result = 0;
		if(bookmarkStatus == 0) {
			result = productService.addBookmark(DUMMY_MEMBER_NO, randomProductNo);
		}else if(bookmarkStatus == 1) {
			result = productService.removeBookmark(DUMMY_MEMBER_NO+randomProductNo);
		}
		
		assertEquals(result, 1);
	}
	
	@Test
	public void addProductTest() throws Exception{
		String product_no = "9999999";
		ProductInsertDto dto = new ProductInsertDto(product_no, DUMMY_MEMBER_NO, 1, 1, "test title", "N", "N", 150000, "test content", "t a g");
		int addResult = productService.addProduct(dto);
		assertEquals(addResult, 1);
		
		int modifyResult = productService.modifyProductState(3, String.valueOf(DUMMY_MEMBER_NO), product_no);
		assertEquals(modifyResult, 1);
	}

}
