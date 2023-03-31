package com.spring.usMarket.dao.member;

import java.util.List;
import java.util.Map;

import com.spring.usMarket.domain.member.MemberDto;
import com.spring.usMarket.domain.product.ProductDto;

public interface MemberDao {
	int insertMember(MemberDto member);
	int overlappedID(String member_id);
	int overlappedNick(String member_nick);
	int overlappedEmail(String member_email);
	void overlapped(String joinMember);
	Map<String, Object> idLogin(String member_id) throws Exception;
	MemberDto memberSearch(Integer member_no) throws Exception;
	
	List<Map<String, Object>> searchMypageProduct(Integer member_no) throws Exception;
	List<ProductDto> searchMypageProduct2(Integer member_no) throws Exception;
	int searchMypageProductCount(Integer member_no) throws Exception;
	
	List<Map<String, Object>> searchMypageBookmark(Integer member_no) throws Exception;
	int searchMypageBookmarkCount(Integer member_no) throws Exception;
	
}
