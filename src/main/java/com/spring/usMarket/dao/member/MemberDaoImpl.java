package com.spring.usMarket.dao.member;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

import com.spring.usMarket.domain.member.MemberDto;
import com.spring.usMarket.domain.product.ProductDto;
import com.spring.usMarket.service.member.MemberService;

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

	@Override
	public MemberDto memberSearch(Integer member_no) throws Exception {
		return session.selectOne(namespace+"memberSearch", member_no);
	}

	@Override
	public List<Map<String, Object>> searchMypageProduct(Integer member_no) throws Exception {
		return session.selectList(namespace+"searchMypageProduct", member_no);
	}

	@Override
	public List<ProductDto> searchMypageProduct2(Integer member_no) throws Exception {
		return session.selectList(namespace+"searchMypageProduct2", member_no);
	}
	
	@Override
	public int searchMypageProductCount(Integer member_no) throws Exception {
		return session.selectOne(namespace+"searchMypageProductCount", member_no);
	}

	@Override
	public List<Map<String, Object>> searchMypageBookmark(Integer member_no) throws Exception {
		return session.selectList(namespace+"searchMypageBookmark", member_no);
	}

	@Override
	public int searchMypageBookmarkCount(Integer member_no) throws Exception {
		return session.selectOne(namespace+"searchMypageBookmarkCount", member_no);
	}
}
