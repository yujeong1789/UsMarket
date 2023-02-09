package com.spring.usMarket.service.member;

import java.util.Map;

import com.spring.usMarket.domain.member.MemberDto;
import com.spring.usMarket.domain.member.MemberFileDto;

public interface MemberService {
	int addMember(MemberDto member);
	int addMemberFile(MemberFileDto memberFileList) throws Exception;
	int checkNick(String member_nick);
	int checkID(String member_id);
	int checkEmail(String member_email);
	Map<String, Object> loginCheckID(String member_id) throws Exception;
}
