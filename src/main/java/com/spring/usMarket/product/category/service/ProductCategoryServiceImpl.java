package com.spring.usMarket.product.category.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.usMarket.product.category.dao.ProductCategoryDao;
import com.spring.usMarket.product.category.domain.ProductCategoryDto;

@Service
public class ProductCategoryServiceImpl implements ProductCategoryService {
	@Autowired
	private ProductCategoryDao productCategoryDao;
	
	@Override
	public List<ProductCategoryDto> searchProductCategory1() throws Exception {
		return productCategoryDao.searchProductCategory1();
	}

	@Override
	public List<ProductCategoryDto> searchProductCategory2(Integer product_category1_no) throws Exception {
		return productCategoryDao.searchProductCategory2(product_category1_no);
	}

}
