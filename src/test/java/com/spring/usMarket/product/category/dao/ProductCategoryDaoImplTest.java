package com.spring.usMarket.product.category.dao;

import static org.junit.Assert.assertEquals;

import java.util.List;

import org.junit.*;
import org.junit.runner.*;
import org.springframework.beans.factory.annotation.*;
import org.springframework.test.context.*;
import org.springframework.test.context.junit4.*;
import org.springframework.test.context.web.WebAppConfiguration;

import com.spring.usMarket.product.dao.ProductCategoryDao;
import com.spring.usMarket.product.domain.ProductCategoryDto;

@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class ProductCategoryDaoImplTest {

	@Autowired
	private ProductCategoryDao dao;
	
	@Test
	public void searchAllCategory() throws Exception {
		List<ProductCategoryDto>cate1=dao.searchProductCategory1();
		for(ProductCategoryDto dto:cate1) {
			List<ProductCategoryDto> cate2=dao.searchProductCategory2(dto.getProduct_category1_no());
			System.out.println(dto.getProduct_category1_no()+". "+dto.getProduct_category1_name());
			for(ProductCategoryDto dto2:cate2) {
				System.out.println("\t"+dto2.getProduct_category2_no()+": "+dto2.getProduct_category2_name());
			}
			System.out.println();
		}
		assertEquals(cate1.size(), 15);
	}
	
	@Test
	public void searchProductCategory1() throws Exception {
		List<ProductCategoryDto>list=dao.searchProductCategory1();
		assertEquals(list.size(), 15);
	}
	
	@Test
	public void searchProductCategory2() throws Exception {
		int randomCategory1=(int)((Math.random()*15)+1); // product_category1 범위 내 난수 생성
		System.out.println("randomCategory1: "+randomCategory1);
		
		int category1=0;
		List<ProductCategoryDto>list=dao.searchProductCategory2(randomCategory1);
		for(ProductCategoryDto dto:list) {
			System.out.println(dto.getProduct_category1_no()+"-"+dto.getProduct_category2_no()+"\t"+dto.getProduct_category2_name());
			category1=dto.getProduct_category1_no();
		}
		assertEquals(randomCategory1, category1);
	}

}
