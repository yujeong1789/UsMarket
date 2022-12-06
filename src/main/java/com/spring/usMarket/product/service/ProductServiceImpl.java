package com.spring.usMarket.product.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.usMarket.common.SearchCondition;
import com.spring.usMarket.product.dao.ProductCategoryDao;
import com.spring.usMarket.product.dao.ProductDao;
import com.spring.usMarket.product.domain.ProductCategoryDto;
import com.spring.usMarket.product.domain.ProductDto;

@Service
public class ProductServiceImpl implements ProductService {
	@Autowired ProductDao productDao;
	@Autowired ProductCategoryDao productCategoryDao;

	
	@Override
	public List<ProductCategoryDto> getProductCategory1() throws Exception {
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

}
