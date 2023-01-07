package com.spring.usMarket.member.dao;

import com.spring.usMarket.member.domain.MemberDto;

public interface MemberDao {
	int insertMember(MemberDto member);
	int overlappedID(String member_id);
	int overlappedNick(String member_nick);
	int overlappedEmail(String member_email);
	int overlapped(String joinMember);
	MemberDto idLogin(String memberId) throws Exception;
}
