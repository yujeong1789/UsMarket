package com.spring.usMarket.service.member;

import java.io.IOException;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.mindrot.jbcrypt.BCrypt;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.CannedAccessControlList;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.PutObjectRequest;
import com.amazonaws.util.IOUtils;
import com.spring.usMarket.dao.member.MemberDao;
import com.spring.usMarket.domain.member.MemberDto;
import com.spring.usMarket.utils.ProfileSearchCondition;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MemberServiceImpl implements MemberService {
	private static final Logger logger = LoggerFactory.getLogger(MemberService.class);

	private final MemberDao memberDAO;

	@Autowired
	private AmazonS3 s3Client;
	
	@Value("${cloud.aws.s3.bucket}")
	private String bucket;
	
	@Value("${cloud.aws.region}")
	private String region;
	
	public String getResult(int rowCnt) {
		return rowCnt == 1 ? "OK" : "NOT_OK";
	}

	public String getPath() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd/");
		Date date = new Date();
		return sdf.format(date);
	}
	
	public String getUUID(String originFileName) {
		return UUID.randomUUID().toString() + "_" + originFileName; 
	}
	
	public String upload(MultipartFile file) throws IOException{
		byte[] bytes = IOUtils.toByteArray(file.getInputStream());
		
		String originalName = file.getOriginalFilename();
		
		ObjectMetadata objectMetadata = new ObjectMetadata();
		objectMetadata.setContentLength(bytes.length);
		objectMetadata.setContentType(file.getContentType());
					
		// 요청 바디 작성
		PutObjectRequest putObjectRequest = new PutObjectRequest(this.bucket, "profile/"+getUUID(originalName), file.getInputStream(), objectMetadata)
				.withCannedAcl(CannedAccessControlList.PublicRead);
		
		// s3에 저장
		this.s3Client.putObject(putObjectRequest);
		
		logger.info("upload complete! {}", putObjectRequest.getKey());
		
		String realPath = "https://"+this.bucket+".s3."+this.region+".amazonaws.com/"+putObjectRequest.getKey();			
		// https://usmarket.s3.ap-northeast-2.amazonaws.com/2023/01/24/2da9322b-f45f-428a-b1b3-bde87f88d052_IMG_5402.PNG
		
		return realPath;
	}
	
	@Transactional
	@Override
	public int addMember(MemberDto member) {
		logger.info("/ Service / memberDto = {}",member.toString());
		member.setMember_password(BCrypt.hashpw(member.getMember_password(), BCrypt.gensalt()));
		int rowCnt = memberDAO.insertMember(member);
		logger.info("회원 등록 결과 = {}", getResult(rowCnt));

		return rowCnt;
	}
	
	@Transactional
	@Override
	public int modifyMember(MemberDto member) {
		logger.info("/ Service / memberDto = {}",member.toString());
		member.setMember_password(BCrypt.hashpw(member.getMember_password(), BCrypt.gensalt()));
		int rowCnt = memberDAO.updateMember(member);
		logger.info("회원 정보 변경 결과 = {}", getResult(rowCnt));

		return rowCnt;
	}
	
	@Transactional
	@Override
	public int resetMember(Map<String, Object> pw) {
		String hashedPw = BCrypt.hashpw((String) pw.get("member_password"), BCrypt.gensalt());
	    logger.info("비밀번호 암호화 값 = {}",hashedPw);
	    
	    pw.put("member_password", hashedPw);
	    logger.info("Service에서 넘긴 값 = {}",pw);
	    
	    int rowCnt = memberDAO.updatePw(pw);
	    logger.info("업데이트 결과 = {}", getResult(rowCnt));
	    
	    return rowCnt;
	}

	@Transactional
	@Override
	public Map<String, Object> searchMember(Map<String, Object> sc) {
		return memberDAO.selectMember(sc);
	}
	
	@Transactional
	@Override
	public String checkNick(String member_nick) {
		return memberDAO.overlappedNick(member_nick);
	}

	@Transactional
	@Override
	public int checkID(String memberId) {
		return memberDAO.overlappedID(memberId);
	}

	@Transactional
	@Override
	public String checkEmail(String member_email) {
		return memberDAO.overlappedEmail(member_email);
	}

	@Transactional
	@Override
	public Map<String, Object> loginCheckID(String member_id) throws Exception {
		return memberDAO.idLogin(member_id);
	}

	@Override
	public MemberDto getMemberInfo(String member_no) throws Exception {
		MemberDto member = memberDAO.memberSearch(Integer.parseInt(member_no));
		logger.info("회원정보 = {}", member.toString());
		
		return member;
	}

	@Override
	@Transactional(rollbackFor = SQLException.class, readOnly = true)
	public List<Map<String, Object>> getProduct(ProfileSearchCondition sc) throws Exception {
		List<Map<String, Object>> productList = memberDAO.searchProduct(sc);
		logger.info("productList = {}",productList);
		
	    return productList;
	}
	
	@Override
	@Transactional(rollbackFor = SQLException.class, readOnly = true)
	public int getProductCnt(String member_no, String condition) throws Exception {
		
		int productCount = memberDAO.searchProductCnt(Integer.parseInt(member_no), condition);
		logger.info("ProductCount = {}", productCount);
		
		return productCount;
	}

	@Override
	@Transactional(rollbackFor = SQLException.class, readOnly = true)
	public List<Map<String, Object>> getBookmark(ProfileSearchCondition sc) throws Exception {
		List<Map<String, Object>> bookmarkList = memberDAO.searchBookmark(sc);
		logger.info("bookmarkList = {}",bookmarkList);
		
		return bookmarkList;
	}

	@Override
	@Transactional(rollbackFor = SQLException.class, readOnly = true)
	public int getBookmarkCnt(String member_no, String condition) throws Exception {
		
		int bookmarkCount = memberDAO.searchBookmarkCnt(Integer.parseInt(member_no), condition);
		logger.info("BookmarkCount = {}", bookmarkCount);
	
		return bookmarkCount;
	}

	@Override
	@Transactional(rollbackFor = SQLException.class, readOnly = true)
	public List<Map<String, Object>> getReview(ProfileSearchCondition sc) throws Exception {
		List<Map<String, Object>> review = memberDAO.searchReview(sc);
		logger.info("review = {}",review);
		
		return review;
	}

	@Override
	public int getReviewCnt(String member_no, String condition) throws Exception {

		int reviewCount = memberDAO.searchReviewCnt(Integer.parseInt(member_no), condition);
		logger.info("ReviewCount = {}", reviewCount);
	
		return reviewCount;
	}

	
}
