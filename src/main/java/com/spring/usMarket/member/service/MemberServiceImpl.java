package com.spring.usMarket.member.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.usMarket.member.dao.MemberDao;
import com.spring.usMarket.member.domain.MemberDto;

import lombok.RequiredArgsConstructor;


@Service
@RequiredArgsConstructor
public class MemberServiceImpl implements MemberService{
		private final MemberDao memberDAO;
		
		@Transactional
		@Override
		public void addMember(MemberDto member) {
			memberDAO.insertMember(member);
		}

		@Transactional
		@Override
		public int checkID(String memberId) {
			return memberDAO.overlappedID(memberId);
		}
		
		@Transactional
		@Override
		public int checkNick(String member_nick) {
			return memberDAO.overlappedNick(member_nick);
		}

		@Transactional
		@Override
		public int checkEmail(String member_email) {
			return memberDAO.overlappedEmail(member_email);
		}

		@Transactional
		@Override
		public int checkOvelap(String joinMember) {
			return memberDAO.overlapped(joinMember);
		}
		
		@Transactional
		@Override
		public MemberDto loginCheckID(String member_id) throws Exception {
			return memberDAO.idLogin(member_id);
		}

		

}
