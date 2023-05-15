package com.usMarket.test.customer;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;

import java.util.HashMap;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.transaction.annotation.Transactional;

import com.spring.usMarket.dao.deal.DealDao;
import com.spring.usMarket.domain.deal.DealInsertDto;

@Transactional
@WebAppConfiguration
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml"})
public class DealTest {

	@Autowired private DealDao dealDao;
	
	@Test
	public void dealTest() throws Exception{
		DealInsertDto dto = new DealInsertDto("TEST", "10000", 2, 3, "customer_name", "hp", "zipcode", "address", "address_detail", "delivery_messgage");
		
		// insert
		int insertResult = dealDao.insertDeal(dto);
		assertEquals(insertResult, 1);
		
		// select
		Map<String, Object> dealInfo = dealDao.searchDealInfo(dto.getDeal_no());
		assertNotNull(dealInfo);
		
		// update
		int updateResult = dealDao.updateDealState("2", dto.getDeal_no());
		assertEquals(updateResult, 1);
		
		// updateDealReview
		int dealReviewCnt = dealDao.updateDealReview(dto.getDeal_no());
		assertEquals(dealReviewCnt, 1);
		
		// insertReview
		int insertReviewResult = dealDao.insertReview(dto.getDeal_no(), "test content", "5");
		assertEquals(insertReviewResult, 1);
		
		// updateDealReview
		int updateReviewResult = dealDao.updateDealReview(dto.getDeal_no());
		assertEquals(updateReviewResult, 1);
		
		// searchReviewInfo
		Map<String, Object> reviewInfo = dealDao.searchReviewInfo(dto.getDeal_no());
		assertNotNull(reviewInfo);
		
		// updateDeliveryState
		Map<String, Object> deliveryState = new HashMap<>();
		deliveryState.put("deal_no", dto.getDeal_no());
		deliveryState.put("deal_delivery_state", "2");
		
		int updateDeliveryResult = dealDao.updateDeliveryState(deliveryState);
		assertEquals(updateDeliveryResult, 1);
		
		// updateDealState
		int updateDealResult = dealDao.updateDealState("3", dto.getDeal_no());
		assertEquals(updateDealResult, 1);	
	}
}
