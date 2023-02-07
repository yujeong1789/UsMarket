package com.spring.usMarket.service.product;

import java.sql.SQLException;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.usMarket.dao.product.ProductCategoryDao;
import com.spring.usMarket.dao.product.ProductDao;
import com.spring.usMarket.domain.product.ProductCategoryDto;
import com.spring.usMarket.domain.product.ProductDto;
import com.spring.usMarket.domain.product.ProductFileDto;
import com.spring.usMarket.domain.product.ProductInsertDto;
import com.spring.usMarket.utils.SearchCondition;
import com.spring.usMarket.utils.TimeConvert;

@Service
public class ProductServiceImpl implements ProductService {
	private static final Logger logger = LoggerFactory.getLogger(ProductService.class);
	
	@Autowired ProductDao productDao;
	@Autowired ProductCategoryDao productCategoryDao;

	
	public String getResult(int rowCnt) {
		return rowCnt == 1 ? "OK" : "NOT_OK";
	}
	
	
	@Override
	@Transactional(rollbackFor = SQLException.class, readOnly = true)
	public List<Map<String, Object>> getProductCategory1() throws Exception {
		
		List<Map<String, Object>> category1 = productCategoryDao.searchProductCategory1(); 
		logger.info("category1.size() = {}", category1.size());
		
		return category1;
	}

	
	@Override
	@Transactional(rollbackFor = SQLException.class, readOnly = true)
	public List<ProductCategoryDto> getProductCategory2(Integer product_category1_no) throws Exception {
		
		List<ProductCategoryDto> category2 = productCategoryDao.searchProductCategory2(product_category1_no);
		logger.info("category2 = {}", category2);
		
		return category2;
	}
	
	@Override
	@Transactional(rollbackFor = SQLException.class, readOnly = true)
	public List<Map<String, Object>> getCategory2(Integer product_category1_no) throws Exception {
		
		List<Map<String, Object>> category2 = productCategoryDao.searchCategory2(product_category1_no);
		logger.info("category2 = {}", category2);
		
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
	@Transactional(rollbackFor = SQLException.class, readOnly = true)
	public Map<String, Object> getProductInfo(String product_no) throws Exception {
		
		Map<String, Object> resultMap = productDao.searchProductInfo(product_no);
		resultMap.put("PRODUCT_REGDATE", TimeConvert.calculateTime((Date)resultMap.get("PRODUCT_REGDATE")));
		logger.info("상품 상세보기 = {}", resultMap.keySet().toString());
		
		return resultMap;
	}
	
	
	@Override
	@Transactional(rollbackFor = SQLException.class, readOnly = true)
	public Map<String, Object> getSellerInfo(Integer seller_no) throws Exception {
		
		Map<String, Object> resultMap = productDao.searchSellerInfo(seller_no);
		logger.info("판매자 정보 = {}", resultMap.keySet());
		
		return resultMap;
	}


	@Override
	@Transactional(rollbackFor = SQLException.class, readOnly = true)
	public List<Map<String, Object>> getReviewByInfo(Integer seller_no) throws Exception {
		
		List<Map<String, Object>> resultMap = productDao.searchReviewByInfo(seller_no);
		logger.info("상위 2건 후기 = {}", resultMap);
		
		return resultMap;
	}


	@Override
	@Transactional(rollbackFor = SQLException.class, readOnly = true)
	public int getBookmarkByInfo(Integer current_no, String product_no) throws Exception {
		
		int rowCnt = productDao.searchBookmarkByInfo(current_no, product_no); 
		logger.info("북마크 추가 여부 = {}", (rowCnt == 1 ? "ADDED" : "NOT_ADDED"));
		
		return rowCnt;
	}


	@Override
	@Transactional(rollbackFor = SQLException.class)
	public int removeBookmark(Integer member_no, String product_no) throws Exception {
		
		int rowCnt = productDao.deleteBookmark(member_no, product_no);
		logger.info("북마크 삭제 결과 = {}", getResult(rowCnt));
		
		return rowCnt;
	}


	@Override
	@Transactional(rollbackFor = SQLException.class)
	public int addBookmark(Integer member_no, String product_no) throws Exception {
		
		int rowCnt = productDao.insertBookmark(member_no, product_no);
		logger.info("북마크 추가 결과 = {}", getResult(rowCnt));
		
		return rowCnt;
	}


	@Override
	@Transactional(rollbackFor = SQLException.class)
	public int modifyProductView(String product_no) throws Exception {
		
		int rowCnt = productDao.updateProductView(product_no);
		logger.info("조회수 증가 결과 = {}", getResult(rowCnt));
		
		return rowCnt;
	}


	@Override
	@Transactional(rollbackFor = SQLException.class)
	public int addProductFile(List<ProductFileDto> productFileList) throws Exception {
		
		int rowCnt = 0;
		for(ProductFileDto dto : productFileList) {
			int result = productDao.insertProductFile(dto);
			rowCnt+=result;
		}
		logger.info("productFileList.size() = {}, 파일 추가 결과 = {}", productFileList.size(), rowCnt);
		
		return rowCnt;
	}


	@Override
	@Transactional(rollbackFor = SQLException.class)
	public int addProduct(ProductInsertDto productInsertDto) throws Exception {
		
		int rowCnt = productDao.insertProduct(productInsertDto);
		logger.info("상품 등록 결과 = {}", getResult(rowCnt));
		
		return rowCnt;
	}


	@Override
	@Transactional(rollbackFor = SQLException.class, readOnly = true)
	public List<String> getProductImage(String product_no) throws Exception {
		
		List<String> productImage = productDao.searchProductImage(product_no);
		logger.info("상품 이미지 = {}", productImage.toString());
		
		return productImage;
	}

	
	@Override
	@Transactional(rollbackFor = SQLException.class)
	public int modifyProductState(Integer product_state_no, String seller_no, String product_no) throws Exception {
		
		int rowCnt = productDao.updateProductState(product_state_no, seller_no, product_no);
		logger.info("상품 상태 업데이트 결과 = {}", getResult(rowCnt));
		
		return rowCnt;
	}

	
	@Override
	@Transactional(rollbackFor = SQLException.class)
	public int removeProductImage(String product_no) throws Exception {
		
		int rowCnt = productDao.deleteProductImage(product_no);
		logger.info("상품 이미지 삭제 결과 = {}", rowCnt);
		
		return rowCnt;
	}


	@Override
	@Transactional(rollbackFor = SQLException.class, readOnly = true)
	public Map<String, Object> getProductOrderInfo(String product_no) throws Exception {
		
		Map<String, Object> resultMap = productDao.searchProductOrderInfo(product_no);
		logger.info("주문 상품 정보 = {}", resultMap.toString());
		
		return resultMap;
	}


	@Override
	public Map<String, Object> getCustomerInfo(String customer_no) throws Exception {
		
		Map<String, Object> resultMap = productDao.searchCustomerInfo(customer_no);
		logger.info("구매회원 정보 = {}", resultMap.toString());
		
		return resultMap;
	}

}
