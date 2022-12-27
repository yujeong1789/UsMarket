package com.spring.usMarket.product.dao;

import java.util.List;

import com.spring.usMarket.common.SearchCondition;
import com.spring.usMarket.product.domain.ProductDto;

public interface ProductDao {
	List<ProductDto> searchMainProduct() throws Exception;
	List<ProductDto> searchProductByCategory(SearchCondition sc) throws Exception;
	int searchProductCount(SearchCondition sc) throws Exception;
	ProductDto searchProductInfo(Integer product_no) throws Exception;
	int updateProductView(Integer product_no) throws Exception;
}
