package com.spring.usMarket.dao.member;

import java.util.List;
import java.util.Map;

import com.spring.usMarket.domain.member.MemberDto;
import com.spring.usMarket.utils.AdminSearchCondition;

public interface MemberDao {
	int insertMember(MemberDto member);
	int updateMember(MemberDto member);
	
	int overlappedID(String member_id);
	String overlappedNick(String member_nick);
	String overlappedEmail(String member_email);
	void overlapped(String joinMember);
	
	Map<String, Object> idLogin(String member_id) throws Exception;
	MemberDto memberSearch(Integer member_no) throws Exception;
	
	List<Map<String, Object>> searchMypageProduct(AdminSearchCondition sc) throws Exception;
	int searchMypageProductCount(Integer member_no) throws Exception;
	
	List<Map<String, Object>> searchMypageBookmark(AdminSearchCondition sc) throws Exception;
	int searchMypageBookmarkCount(Integer member_no) throws Exception;
	
}
