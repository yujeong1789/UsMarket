package com.spring.usMarket.service.deal;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.usMarket.dao.deal.DealDao;
import com.spring.usMarket.dao.product.ProductDao;
import com.spring.usMarket.domain.deal.DealInsertDto;
import com.spring.usMarket.service.chat.ChatService;

@Service
public class DealServiceImpl implements DealService{
	private static final Logger logger = LoggerFactory.getLogger(DealService.class);
	
	@Autowired DealDao dealDao;
	@Autowired ProductDao productDao;
	
	public String getResult(int rowCnt) {
		return rowCnt == 1 ? "SUCCESS" : "FAIL";
	}
	
	@Override
	@Transactional(rollbackFor = SQLException.class)
	public boolean addDeal(DealInsertDto dto, String isUpdate) throws Exception {
		int cnt = 0;
		int result = 0;
		// 주소 업데이트 체크시 수행
		if(isUpdate.equals("Y") || isUpdate == "Y") {
			int updateAddressCnt = dealDao.updateAddress(dto.getCustomer_zipcode(), dto.getCustomer_address(), dto.getCustomer_address_detail(), dto.getCustomer_no());
			cnt++;
			result += updateAddressCnt;
			logger.info("회원 주소 업데이트 결과 = {}", getResult(updateAddressCnt));
		}
		
		// 거래내역 insert
		int insertDealCnt = dealDao.insertDeal(dto);
		cnt++;
		result += insertDealCnt;
		logger.info("거래내역 등록 결과 = {}", getResult(insertDealCnt));
		
		// 해당 상품 판매완료 처리
		int modifyProductCnt = productDao.updateProductState(3, dto.getSeller_no().toString(), dto.getProduct_no().toString());
		logger.info("seller_no = {}, product_no = {}", dto.getSeller_no(), dto.getProduct_no());
		cnt++;
		result += modifyProductCnt;
		logger.info("상품 판매완료 처리 결과 = {}", getResult(modifyProductCnt));
		
		return cnt == result ? true : false;
	}

	@Override
	@Transactional(rollbackFor = SQLException.class, readOnly = true)
	public List<Map<String, Object>> getDealList(String state, String condition, String member_no) throws Exception {
		
		List<Map<String, Object>> listMap = dealDao.searchDealList(state, condition, member_no);
		logger.info("거래내역 목록 조회 결과 = {}건", listMap.size());
		
		return listMap;
	}

	@Override
	@Transactional(rollbackFor = SQLException.class, readOnly = true)
	public Map<String, Object> getDealInfo(String deal_no) throws Exception {
		
		Map<String, Object> map = dealDao.searchDealInfo(deal_no);
		logger.info("거래내역 조회 결과 = {}", map.toString());
		
		return map;
	}

	@Override
	@Transactional(rollbackFor = SQLException.class)
	public int modifyDealState(String deal_state, String deal_no) throws Exception {
		
		int rowCnt = dealDao.updateDealState(deal_state, deal_no);
		logger.info("거래상태 업데이트 결과 = {}", getResult(rowCnt));
		
		return rowCnt;
	}

	@Override
	@Transactional(rollbackFor = SQLException.class)
	public int modifyDealCancel(String deal_cancel, String deal_no) throws Exception {

		int rowCnt = dealDao.updateDealCancel(deal_cancel, deal_no);
		logger.info("취소신청 결과 = {}", getResult(rowCnt));
		
		return rowCnt;
	}

	@Override
	@Transactional(rollbackFor = SQLException.class)
	public int modifyDeliveryState(Map<String, Object> map) throws Exception {
		
		int rowCnt = dealDao.updateDeliveryState(map);
		logger.info("배송상태 변경 결과 = {}", getResult(rowCnt));

		return rowCnt;
	}

	@Override
	@Transactional(rollbackFor = SQLException.class, readOnly = true)
	public Map<String, Object> getReviewInfo(String deal_no) throws Exception {
		
		Map<String, Object> map = dealDao.searchReviewInfo(deal_no);
		logger.info("리뷰 조회 결과 = {}", map.toString());
		
		return map;
	}

	@Override
	@Transactional(rollbackFor = SQLException.class)
	public int addReview(String deal_no, String review_content, String review_score) throws Exception {
		
		int updateCnt = dealDao.updateDealReview(deal_no);
		int insertCnt = dealDao.insertReview(deal_no, review_content, review_score);
		logger.info("리뷰 작성 상태 업데이트 결과 = {}, 리뷰 작성 결과 = {}", getResult(updateCnt), getResult(insertCnt));
		
		return updateCnt + insertCnt;
	}

	@Override
	@Transactional(rollbackFor = SQLException.class, readOnly = true)
	public String getChatRoom(String chat_member_1, String chat_member_2) throws Exception {

		String room_no = dealDao.searchChatRoom(chat_member_1, chat_member_2);
		logger.info("room_no = {}", room_no);
		
		return room_no;
	}

}
