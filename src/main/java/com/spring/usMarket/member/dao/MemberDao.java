package com.spring.usMarket.member.dao;

import java.util.Map;

import com.spring.usMarket.member.domain.MemberDto;

public interface MemberDao {
	int insertMember(MemberDto member);
	int overlappedID(String member_id);
	int overlappedNick(String member_nick);
	int overlappedEmail(String member_email);
	void overlapped(String joinMember);
	Map<String, Object> idLogin(String member_id) throws Exception;
}
