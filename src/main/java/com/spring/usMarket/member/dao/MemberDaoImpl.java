package com.spring.usMarket.member.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.spring.usMarket.member.domain.MemberDto;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class MemberDaoImpl implements MemberDao{
	private final SqlSession session;
	private static String namespace="com.mybatis.mapper.member.";
	
	@Override
	public int insertMember(MemberDto member) {
		return session.insert(namespace+"insertMember", member);
	}

	@Override
	public int overlappedID(String member_id) {
		return session.selectOne(namespace+"overlappedID", member_id);
	}

	@Override
	public int overlappedNick(String member_nick) {
		return session.selectOne(namespace+"overlappedNick", member_nick);
	}

	@Override
	public int overlappedEmail(String member_email) {
		return session.selectOne(namespace+"overlappedEmail", member_email);
	}
	
	@Override
	public void overlapped(String joinMember) {
		System.out.println("DaoImpl = "+joinMember);
		session.selectOne(namespace+"overlapped", joinMember);
	}
	
	@Override
	public Map<String, Object> idLogin(String member_id) throws Exception {
		return session.selectOne(namespace+"idLogin", member_id);
	}

}
