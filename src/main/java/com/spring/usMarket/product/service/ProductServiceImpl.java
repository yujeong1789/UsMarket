package com.spring.usMarket.product.service;

import java.sql.SQLException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.spring.usMarket.common.SearchCondition;
import com.spring.usMarket.common.TimeConvert;
import com.spring.usMarket.product.controller.ProductController;
import com.spring.usMarket.product.dao.ProductCategoryDao;
import com.spring.usMarket.product.dao.ProductDao;
import com.spring.usMarket.product.domain.ProductCategoryDto;
import com.spring.usMarket.product.domain.ProductDto;

@Service
public class ProductServiceImpl implements ProductService {
	private static final Logger logger = LoggerFactory.getLogger(ProductController.class);
	
	@Autowired ProductDao productDao;
	@Autowired ProductCategoryDao productCategoryDao;

	
	@Override
	@Transactional(rollbackFor = SQLException.class, readOnly = true)
	public List<Map<String, Object>> getProductCategory1() throws Exception {
		
		List<Map<String, Object>> category1 = productCategoryDao.searchProductCategory1(); 
		logger.info("카테고리1.size() = {}", category1.size());
		
		return category1;
	}

	
	@Override
	@Transactional(rollbackFor = SQLException.class, readOnly = true)
	public List<ProductCategoryDto> getProductCategory2(Integer product_category1_no) throws Exception {
		
		List<ProductCategoryDto> category2 = productCategoryDao.searchProductCategory2(product_category1_no);
		logger.info("카테고리2 = {}", category2);
		
		return category2;
	}

	
	@Override
	@Transactional(rollbackFor = SQLException.class, readOnly = true)
	public List<ProductDto> getMainProduct() throws Exception {
		
		List<ProductDto> mainProduct = productDao.searchMainProduct();
		logger.info("메인 페이지 상품.size() = {}", mainProduct.size());
		
		return mainProduct;
	}

	
	@Override
	@Transactional(rollbackFor = SQLException.class, readOnly = true)
	public List<ProductDto> getProductByCategory(SearchCondition sc) throws Exception {
		
		logger.info("SearchCondition = {}", sc);
		
		List<ProductDto> listProduct = productDao.searchProductByCategory(sc);
		logger.info("페이지 내 상품 리스트.size() = {}", listProduct.size());
		
		return listProduct;
	}

	
	@Override
	@Transactional(rollbackFor = SQLException.class, readOnly = true)
	public int getProductCount(SearchCondition sc) throws Exception {
		
		int productCount = productDao.searchProductCount(sc);
		logger.info("전체 상품 수 = {}", productCount);
		
		return productCount;
	}

	
	@Override
	@Transactional(rollbackFor = SQLException.class)
	public Map<String, Object> getProductInfo(Integer product_no) throws Exception {
		
		int updateCnt = productDao.updateProductView(product_no);
		logger.info("조회수 증가 발생, updateCnt = {}", updateCnt);
		
		Map<String, Object> resultMap = productDao.searchProductInfo(product_no);
		resultMap.put("PRODUCT_REGDATE", TimeConvert.calculateTime((Date)resultMap.get("PRODUCT_REGDATE")));
		logger.info("상품 상세보기 = {}", resultMap);
		
		return resultMap;
	}
	
	
	@Override
	@Transactional(rollbackFor = SQLException.class, readOnly = true)
	public Map<String, Object> getSellerInfo(Integer seller_no) throws Exception {
		
		Map<String, Object> resultMap = productDao.searchSellerInfo(seller_no);
		logger.info("판매자 정보 = {}", resultMap);
		
		return resultMap;
	}


	@Override
	@Transactional(rollbackFor = SQLException.class, readOnly = true)
	public List<Map<String, Object>> getReviewByInfo(Integer seller_no) throws Exception {
		
		List<Map<String, Object>> resultMap = productDao.searchReviewByInfo(seller_no);
		logger.info("상위 2건 후기 = {}", resultMap);
		
		return resultMap;
	}

}
