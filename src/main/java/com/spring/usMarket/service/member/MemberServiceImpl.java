package com.spring.usMarket.service.member;

import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.spring.usMarket.dao.member.MemberDao;
import com.spring.usMarket.domain.member.MemberDto;
import com.spring.usMarket.domain.member.MemberFileDto;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MemberServiceImpl implements MemberService {
	private static final Logger logger = LoggerFactory.getLogger(MemberService.class);

	private final MemberDao memberDAO;

	public String getResult(int rowCnt) {
		return rowCnt == 1 ? "OK" : "NOT_OK";
	}

	@Transactional
	@Override
	public int addMember(MemberDto member) {
		logger.info("/ Service / memberDto = {}",member.toString());
		
		int rowCnt = memberDAO.insertMember(member);
		logger.info("회원 등록 결과 = {}", getResult(rowCnt));

		return memberDAO.insertMember(member);
	}

	@Override
	public int addMemberFile(MemberFileDto memberFile) throws Exception {

		int rowCnt = 0;
		//int result = memberDAO.insertMemberFile(member);
		//rowCnt+=result;
		
		logger.info("productFileList.size() = {}, 파일 추가 결과 = {}", memberFile, rowCnt);

		return rowCnt;
	}

	@Transactional
	@Override
	public int checkNick(String member_nick) {
		return memberDAO.overlappedNick(member_nick);
	}

	@Transactional
	@Override
	public int checkID(String memberId) {
		return memberDAO.overlappedID(memberId);
	}

	@Transactional
	@Override
	public int checkEmail(String member_email) {
		return memberDAO.overlappedEmail(member_email);
	}

	@Transactional
	@Override
	public Map<String, Object> loginCheckID(String member_id) throws Exception {
		return memberDAO.idLogin(member_id);
	}

}
