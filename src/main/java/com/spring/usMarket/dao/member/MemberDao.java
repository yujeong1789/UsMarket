package com.spring.usMarket.dao.member;

import java.util.List;
import java.util.Map;

import com.spring.usMarket.domain.member.MemberDto;
import com.spring.usMarket.utils.ProfileSearchCondition;

public interface MemberDao {
	int insertMember(MemberDto member);
	int updateMember(MemberDto member);
	int updatePw(Map<String, Object> pw);
	Map<String, Object> selectMember(Map<String, Object> sc);
	
	int overlappedID(String member_id);
	String overlappedNick(String member_nick);
	String overlappedEmail(String member_email);
	void overlapped(String joinMember);
	
	Map<String, Object> idLogin(String member_id) throws Exception;
	MemberDto memberSearch(Integer member_no) throws Exception;
	List<Map<String, Object>> productStateCnt(Integer member_no) throws Exception;
	
	List<Map<String, Object>> searchProduct(ProfileSearchCondition sc) throws Exception;
	int searchProductCnt(Integer member_no, String condition) throws Exception;
	
	List<Map<String, Object>> searchBookmark(ProfileSearchCondition sc) throws Exception;
	int searchBookmarkCnt(Integer member_no, String condition) throws Exception;
	
	List<Map<String, Object>> searchReview(ProfileSearchCondition sc) throws Exception;
	int searchReviewCnt(Integer member_no, String condition) throws Exception;
}
