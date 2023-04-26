package com.spring.usMarket.dao.member;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.spring.usMarket.domain.member.MemberDto;
import com.spring.usMarket.service.member.MemberService;
import com.spring.usMarket.utils.ProfileSearchCondition;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class MemberDaoImpl implements MemberDao{
	private static final Logger logger = LoggerFactory.getLogger(MemberService.class);

	private final SqlSession session;
	private static String namespace="com.mybatis.mapper.member.";
	
	@Override
	public int insertMember(MemberDto member) {
		logger.info("/ DaoImpl / memberDto = {}",member.toString());
		return session.insert(namespace+"insertMember", member);
	}

	@Override
	public int updateMember(MemberDto member) {
		return session.insert(namespace+"updateMember", member);
	}
	
	@Override
	public int updatePw(Map<String, Object> pw) {
		logger.info("업데이트할 데이터 = {}",pw);
		return session.insert(namespace+"updatePw", pw);
	}
	
	@Override
	public Map<String, Object> selectMember(Map<String, Object> sc) {
		return session.selectOne(namespace+"selectMember", sc);
	}
	
	@Override
	public int overlappedID(String member_id) {
		return session.selectOne(namespace+"overlappedID", member_id);
	}

	@Override
	public String overlappedNick(String member_nick) {
		return session.selectOne(namespace+"overlappedNick", member_nick);
	}

	@Override
	public String overlappedEmail(String member_email) {
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

	@Override
	public MemberDto memberSearch(Integer member_no) throws Exception {
		return session.selectOne(namespace+"memberSearch", member_no);
	}

	@Override
	public List<Map<String, Object>> searchProduct(ProfileSearchCondition sc) throws Exception {
		return session.selectList(namespace+"searchProfileProduct", sc);
	}

	@Override
	public int searchProductCnt(Integer member_no, String condition) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("member_no", member_no);
		map.put("condition", condition);
		
		return session.selectOne(namespace+"searchProfileProductCnt", map);
	}

	@Override
	public List<Map<String, Object>> searchBookmark(ProfileSearchCondition sc) throws Exception {
		return session.selectList(namespace+"searchProfileBookmark", sc);
	}

	@Override
	public int searchBookmarkCnt(Integer member_no, String condition) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("member_no", member_no);
		map.put("condition", condition);
		
		return session.selectOne(namespace+"searchProfileBookmarkCnt", map);
	}

	@Override
	public List<Map<String, Object>> searchReview(ProfileSearchCondition sc) throws Exception {
		return session.selectList(namespace+"searchProfileReview", sc);
	}

	@Override
	public int searchReviewCnt(Integer member_no, String condition) throws Exception {
		Map<String, Object> map = new HashMap<>();
		map.put("member_no", member_no);
		map.put("condition", condition);
		
		return session.selectOne(namespace+"searchProfileReviewCnt", map);
	}
}
