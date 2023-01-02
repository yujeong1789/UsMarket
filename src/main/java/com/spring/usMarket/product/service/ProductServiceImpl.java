package com.spring.usMarket.product.service;

import java.sql.SQLException;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.usMarket.common.SearchCondition;
import com.spring.usMarket.common.TimeConvert;
import com.spring.usMarket.product.dao.ProductCategoryDao;
import com.spring.usMarket.product.dao.ProductDao;
import com.spring.usMarket.product.domain.ProductCategoryDto;
import com.spring.usMarket.product.domain.ProductDto;

@Service
public class ProductServiceImpl implements ProductService {
	@Autowired ProductDao productDao;
	@Autowired ProductCategoryDao productCategoryDao;

	
	@Override
	public List<Map<String, Object>> getProductCategory1() throws Exception {
		return productCategoryDao.searchProductCategory1();
	}

	@Override
	public List<ProductCategoryDto> getProductCategory2(Integer product_category1_no) throws Exception {
		return productCategoryDao.searchProductCategory2(product_category1_no);
	}

	@Override
	public List<ProductDto> getMainProduct() throws Exception {
		return productDao.searchMainProduct();
	}

	@Override
	public List<ProductDto> getProductByCategory(SearchCondition sc) throws Exception {
		return productDao.searchProductByCategory(sc);
	}

	@Override
	public int getProductCount(SearchCondition sc) throws Exception {
		return productDao.searchProductCount(sc);
	}

	@Override
	@Transactional(rollbackFor = SQLException.class)
	public Map<String, Object> getProductInfo(Integer product_no) throws Exception {
		productDao.updateProductView(product_no);
		Map<String, Object> resultMap = productDao.searchProductInfo(product_no);
		resultMap.put("PRODUCT_REGDATE", TimeConvert.calculateTime((Date)resultMap.get("PRODUCT_REGDATE")));
		
		return resultMap;
	}

}
