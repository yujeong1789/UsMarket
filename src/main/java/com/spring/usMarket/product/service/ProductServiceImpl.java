package com.spring.usMarket.product.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.usMarket.common.SearchCondition;
import com.spring.usMarket.product.dao.ProductCategoryDao;
import com.spring.usMarket.product.dao.ProductDao;
import com.spring.usMarket.product.domain.ProductCategoryDto;
import com.spring.usMarket.product.domain.ProductDto;
import com.spring.usMarket.product.domain.ProductPageHandler;

@Service
public class ProductServiceImpl implements ProductService {
	@Autowired ProductDao productDao;
	@Autowired ProductCategoryDao productCategoryDao;

	@Override
	public List<ProductCategoryDto> getProductCategory1() throws Exception {
		// TODO Auto-generated method stub
		return productCategoryDao.searchProductCategory1();
	}

	@Override
	public List<ProductCategoryDto> getProductCategory2(Integer product_category1_no) throws Exception {
		// TODO Auto-generated method stub
		return productCategoryDao.searchProductCategory2(product_category1_no);
	}

	@Override
	public List<ProductDto> getMainProduct() throws Exception {
		// TODO Auto-generated method stub
		return productDao.searchMainProduct();
	}

	@Override
	public List<ProductDto> getProductByCategory(ProductPageHandler ph) throws Exception {
		// TODO Auto-generated method stub
		return productDao.searchProductByCategory(ph);
	}

}
