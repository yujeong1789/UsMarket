package com.usMarket.product;

import static org.junit.Assert.assertEquals;

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

import com.spring.usMarket.common.SearchCondition;
import com.spring.usMarket.product.domain.ProductCategoryDto;
import com.spring.usMarket.product.domain.ProductDto;
import com.spring.usMarket.product.service.ProductService;

@Transactional
@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class ProductServiceImplTest {
	
	private static int member_no = 43;
	private static int randomCategory1 = (int)((Math.random()*15)+1); // product_category1 범위 내 난수 생성
	
	@Autowired private ProductService productService;
	
	@Test
	public void getCategory1Test() throws Exception{
		List<Map<String, Object>> list = productService.getProductCategory1();
		assertEquals(list.size(), 15);
	}
	
	@Test
	public void getCategory2Test() throws Exception{
 		System.out.println("randomCategory1 = "+randomCategory1);
		
		List<ProductCategoryDto> category2 = productService.getProductCategory2(randomCategory1);
				
		int category1_no = 0;
		for (ProductCategoryDto dto : category2) {
			System.out.println(dto.getProduct_category2_no()+"\t"+dto.getProduct_category2_name());
			category1_no = dto.getProduct_category1_no();
		}
		assertEquals(randomCategory1, category1_no);
	}
	
	@Test
	public void setBookmarkTest() throws Exception{
		List<ProductDto> productList = productService.getProductByCategory(new SearchCondition(1, 30, "", "", 1, 1));
		
		List<Integer> productNoList = new ArrayList<>();
		for (ProductDto dto : productList) {
			productNoList.add(dto.getProduct_no());
		}
		
		int randomProductNo = productNoList.get((int)((Math.random()*productNoList.size())));
		int bookmarkStatus = productService.getBookmarkByInfo(member_no, randomProductNo);
		
		int result = 0;
		if(bookmarkStatus == 0) {
			result = productService.addBookmark(member_no, randomProductNo);
		}else if(bookmarkStatus == 1) {
			result = productService.removeBookmark(member_no, randomProductNo);
		}
		
		System.out.println("setBookmarkTest = " + (result == 1 ? "PASS" : "FAIL"));
		assertEquals(result, 1);
	}

}
