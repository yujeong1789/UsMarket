package com.spring.usMarket.service.member;

import java.io.IOException;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.spring.usMarket.domain.member.MemberDto;
import com.spring.usMarket.domain.member.MemberFileDto;

public interface MemberService {
	int addMember(MemberDto member);
	int addMemberFile(MemberFileDto memberFileList) throws Exception;
	int checkNick(String member_nick);
	int checkID(String member_id);
	int checkEmail(String member_email);
	Map<String, Object> loginCheckID(String member_id) throws Exception;
	MemberFileDto upload(MultipartFile file, Integer member_no)throws IOException;
}
