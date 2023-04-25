package com.spring.usMarket.service.deal;

import java.util.List;
import java.util.Map;

import com.spring.usMarket.domain.deal.DealInsertDto;

public interface DealService {
	boolean addDeal(DealInsertDto dto, String isUpdate) throws Exception;
	List<Map<String, Object>> getDealList(String state, String condition, String member_no) throws Exception;
	Map<String, Object> getDealInfo(String deal_no) throws Exception;
	int modifyDealState(String deal_state, String deal_no) throws Exception;
	int modifyDealCancel(String deal_cancel, String deal_no) throws Exception;
	int modifyDeliveryState(Map<String, Object> map) throws Exception;
	Map<String, Object> getReviewInfo(String deal_no) throws Exception;
	int addReview(String deal_no, String review_content, String review_score) throws Exception;
	String getChatRoom(String chat_member_1, String chat_member_2) throws Exception;
}
