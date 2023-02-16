package com.spring.usMarket.service.member;

import java.io.IOException;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.spring.usMarket.domain.member.MemberDto;

public interface MemberService {
	int addMember(MemberDto member);
	int checkNick(String member_nick);
	int checkID(String member_id);
	int checkEmail(String member_email);
	Map<String, Object> loginCheckID(String member_id) throws Exception;
	String upload(MultipartFile file)throws IOException;
	Map<Integer, Object> getMemberInfo(Integer member_no) throws Exception;
}
