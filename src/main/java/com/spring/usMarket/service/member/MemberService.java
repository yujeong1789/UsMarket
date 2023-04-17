package com.spring.usMarket.service.member;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.spring.usMarket.domain.member.MemberDto;
import com.spring.usMarket.utils.ProfileSearchCondition;

public interface MemberService {
	int addMember(MemberDto member);
	int modifyMember (MemberDto member);
	
	String checkNick(String member_nick);
	int checkID(String member_id);
	String checkEmail(String member_email);
	
	Map<String, Object> loginCheckID(String member_id) throws Exception;
	String upload(MultipartFile file)throws IOException;
	MemberDto getMemberInfo(String member_no) throws Exception;
	
	List<Map<String, Object>> getMypageProduct(ProfileSearchCondition sc) throws Exception;
	int getMypageProductCount(String member_no, String condition) throws Exception;
	
	List<Map<String, Object>> getMypageBookmark(ProfileSearchCondition sc) throws Exception;
	int getMypageBookmarkCount(String member_no, String condition) throws Exception;
	
}
