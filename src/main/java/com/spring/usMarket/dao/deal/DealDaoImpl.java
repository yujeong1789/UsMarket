package com.spring.usMarket.dao.deal;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.usMarket.domain.deal.DealInsertDto;

@Repository
public class DealDaoImpl implements DealDao{
	@Autowired
	private SqlSession session;
	private static String namespace = "com.mybatis.mapper.deal.";
	
	@Override
	public int insertDeal(DealInsertDto dto) throws Exception {
		return session.insert(namespace+"insertDeal", dto);
	}

	@Override
	public int updateAddress(String member_zipcode, String member_address, String member_address_detail, Integer customer_no)
			throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("member_zipcode", member_zipcode);
		map.put("member_address", member_address);
		map.put("member_address_detail", member_address_detail);
		map.put("member_no", customer_no);
		
		return session.update(namespace+"updateAddress", map);
	}

	@Override
	public List<Map<String, Object>> searchDealList(String state, String condition, String member_no) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("state", state);
		map.put("condition", condition);
		map.put("member_no", member_no);
		
		return session.selectList(namespace+"searchDealList", map);
	}

	@Override
	public Map<String, Object> searchDealInfo(String deal_no) throws Exception {
		return session.selectOne(namespace+"searchDealInfo", deal_no);
	}

	@Override
	public int updateDealState(String deal_state, String deal_no) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("deal_state", deal_state);
		map.put("deal_no", deal_no);
		
		return session.update(namespace+"updateDealState", map);
	}

	@Override
	public int updateDealCancel(String deal_cancel, String deal_no) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("deal_cancel", deal_cancel);
		map.put("deal_no", deal_no);
		
		return session.update(namespace+"updateDealCancel", map);
	}

	@Override
	public int updateDeliveryState(Map<String, Object> map) throws Exception {
		return session.update(namespace+"updateDeliveryState", map);
	}

	@Override
	public Map<String, Object> searchReviewInfo(String deal_no) throws Exception {
		return session.selectOne(namespace+"searchReviewInfo", deal_no);
	}

	@Override
	public int insertReview(String deal_no, String review_content, String review_score) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("deal_no", deal_no);
		map.put("review_content", review_content);
		map.put("review_score", review_score);
		
		return session.insert(namespace+"insertReview", map);
	}

	@Override
	public int updateDealReview(String deal_no) throws Exception {
		return session.update(namespace+"updateDealReview", deal_no);
	}

	@Override
	public String searchChatRoom(String chat_member_1, String chat_member_2) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("chat_member_1", chat_member_1);
		map.put("chat_member_2", chat_member_2);
		
		return session.selectOne(namespace+"searchChatRoom", map);
	}

}
