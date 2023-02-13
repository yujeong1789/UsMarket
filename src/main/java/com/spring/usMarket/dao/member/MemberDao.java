package com.spring.usMarket.dao.member;

import java.util.Map;

import com.spring.usMarket.domain.member.MemberDto;
import com.spring.usMarket.domain.member.MemberFileDto;

public interface MemberDao {
	int insertMember(MemberDto member);
	int insertMemberFile(MemberFileDto memberFileDto) throws Exception;	
	int overlappedID(String member_id);
	int overlappedNick(String member_nick);
	int overlappedEmail(String member_email);
	void overlapped(String joinMember);
	Map<String, Object> idLogin(String member_id) throws Exception;
}
