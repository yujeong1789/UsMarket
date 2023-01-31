package com.spring.usMarket.product.dao;

import java.util.HashMap;
import java.util.List;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.usMarket.common.SearchCondition;
import com.spring.usMarket.product.domain.ProductDto;
import com.spring.usMarket.product.domain.ProductFileDto;
import com.spring.usMarket.product.domain.ProductInsertDto;

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
	public List<ProductDto> searchProductByCategory(SearchCondition sc) throws Exception {
		return session.selectList(namespace+"searchProductByCategory", sc);
	}

	@Override
	public int searchProductCount(SearchCondition sc) throws Exception {
		return session.selectOne(namespace+"searchProductCount", sc);
	}

	@Override
	public int searchMemberNo(String member_id) throws Exception {
		return session.selectOne(namespace+"searchMemberNo", member_id);
	}
	
	@Override
	public Map<String, Object> searchProductInfo(String product_no) throws Exception {
		return session.selectOne(namespace+"searchProductInfo", product_no);
	}

	@Override
	public int updateProductView(String product_no) throws Exception {
		return session.update(namespace+"updateProductView", product_no);
	}

	@Override
	public Map<String, Object> searchSellerInfo(Integer seller_no) throws Exception {
		return session.selectOne(namespace+"searchSellerInfo", seller_no);
	}

	@Override
	public List<Map<String, Object>> searchReviewByInfo(Integer seller_no) throws Exception {
		return session.selectList(namespace+"searchReviewByInfo", seller_no);
	}

	@Override
	public int searchBookmarkByInfo(Integer current_no, String product_no) throws Exception {
		
		Map<String, Object> map = new HashMap<>();
		map.put("current_no", current_no);
		map.put("product_no", product_no);
		
		return session.selectOne(namespace+"searchBookmarkByInfo", map);
	}

	@Override
	public int deleteBookmark(Integer member_no, String product_no) throws Exception {
		
		Map<String, Object> map = new HashMap<>();
		map.put("member_no", member_no);
		map.put("product_no", product_no);
		
		return session.delete(namespace+"deleteBookmark", map);
	}

	@Override
	public int insertBookmark(Integer member_no, String product_no) throws Exception {
		
		Map<String, Object> map = new HashMap<>();
		map.put("member_no", member_no);
		map.put("product_no", product_no);
		
		return session.insert(namespace+"insertBookmark", map);
	}

	@Override
	public int insertProductFile(ProductFileDto productFileDto) throws Exception {
		return session.insert(namespace+"insertProductFile", productFileDto);
	}

	@Override
	public int insertProduct(ProductInsertDto productInsertDto) throws Exception {
		return session.insert(namespace+"insertProduct", productInsertDto);
	}

	@Override
	public List<String> searchProductImage(String product_no) throws Exception {
		return session.selectList(namespace+"searchProductImage", product_no);
	}

	@Override
	public int updateProductState(Integer product_state_no, String seller_no, String product_no) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("product_state_no", product_state_no);
		map.put("seller_no", seller_no);
		map.put("product_no", product_no);
		
		return session.update(namespace+"updateProductState", map);
	}

	@Override
	public int deleteProductImage(String product_no) throws Exception {
		return session.delete(namespace+"deleteProductImage", product_no);
	}

	@Override
	public Map<String, Object> searchProductOrderInfo(String product_no) throws Exception {
		return session.selectOne(namespace+"searchProductOrderInfo", product_no);
	}

	@Override
	public Map<String, Object> searchCustomerInfo(String customer_no) throws Exception {
		return session.selectOne(namespace+"searchCustomerInfo", customer_no);
	}	

}
