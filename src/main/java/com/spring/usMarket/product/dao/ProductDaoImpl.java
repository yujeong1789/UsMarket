package com.spring.usMarket.product.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.usMarket.common.SearchCondition;
import com.spring.usMarket.product.domain.ProductCategoryDto;
import com.spring.usMarket.product.domain.ProductDto;
import com.spring.usMarket.product.domain.ProductPageHandler;

@Repository
public class ProductDaoImpl implements ProductDao {
	@Autowired 
	private SqlSession session;
	private static String namespace="com.mybatis.mapper.product.";
	
	@Override
	public List<ProductDto> searchMainProduct() throws Exception {
		return session.selectList(namespace+"searchMainProduct");
	}

	@Override
	public List<ProductDto> searchProductByCategory(ProductPageHandler ph) throws Exception {
		return session.selectList(namespace+"searchProductByCategory", ph);
	}

}
