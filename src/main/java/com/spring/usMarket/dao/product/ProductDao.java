package com.spring.usMarket.dao.product;

import java.util.List;
import java.util.Map;

import com.spring.usMarket.domain.product.ProductDto;
import com.spring.usMarket.domain.product.ProductFileDto;
import com.spring.usMarket.domain.product.ProductInsertDto;
import com.spring.usMarket.utils.SearchCondition;

public interface ProductDao {
	List<ProductDto> searchMainProduct() throws Exception;
	
	List<ProductDto> searchProductByCategory(SearchCondition sc) throws Exception;
	
	int searchProductCount(SearchCondition sc) throws Exception;
	
	Map<String, Object> searchProductInfo(String product_no) throws Exception;
	
	int updateProductView(String product_no) throws Exception;
	
	Map<String, Object> searchSellerInfo(Integer seller_no) throws Exception;
	
	List<Map<String, Object>> searchReviewByInfo(Integer seller_no) throws Exception;
	
	int searchBookmarkByInfo(Integer current_no, String product_no) throws Exception;
	
	int deleteBookmark(Integer member_no, String product_no) throws Exception;
	
	int insertBookmark(Integer member_no, String product_no) throws Exception;
	
	int searchMemberNo(String member_id) throws Exception;
	
	int insertProduct(ProductInsertDto productInsertDto) throws Exception;
	
	int insertProductFile(ProductFileDto productFileDto) throws Exception;
	
	List<String> searchProductImage(String product_no) throws Exception;
	
	int updateProductState(Integer product_state_no, String seller_no, String product_no) throws Exception;
	
	int deleteProductImage(String product_no) throws Exception;
	
	Map<String, Object> searchProductOrderInfo(String product_no) throws Exception;
	
	Map<String, Object> searchCustomerInfo(String customer_no) throws Exception;
}
