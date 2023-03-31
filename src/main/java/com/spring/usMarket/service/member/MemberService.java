package com.spring.usMarket.service.member;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.spring.usMarket.domain.member.MemberDto;
import com.spring.usMarket.domain.product.ProductDto;

public interface MemberService {
	int addMember(MemberDto member);
	int checkNick(String member_nick);
	int checkID(String member_id);
	int checkEmail(String member_email);
	Map<String, Object> loginCheckID(String member_id) throws Exception;
	String upload(MultipartFile file)throws IOException;
	MemberDto getMemberInfo(String member_no) throws Exception;
	
	List<Map<String, Object>> getMypageProduct(String member_no) throws Exception;
	int getMypageProductCount(String member_no) throws Exception;
	
	List<Map<String, Object>> getMypageBookmark(String member_no) throws Exception;
	int getMypageBookmarkCount(String member_no) throws Exception;
	
}
