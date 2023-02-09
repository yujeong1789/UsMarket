package com.spring.usMarket.service.member;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.CannedAccessControlList;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.PutObjectRequest;
import com.amazonaws.util.IOUtils;
import com.spring.usMarket.controller.MemberController;
import com.spring.usMarket.domain.member.MemberFileDto;

@Service
@PropertySource("classpath:props/fileUpload.properties")
public class MemberFileService {
private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	private AmazonS3 s3Client;
	
	@Value("${cloud.aws.s3.bucket}")
	private String bucket;
	
	@Value("${cloud.aws.region}")
	private String region;
	
	public String getPath() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd/");
		Date date = new Date();
		return sdf.format(date);
	}
	
	public String getUUID(String originFileName) {
		return UUID.randomUUID().toString() + "_" + originFileName; 
	}
	
	public MemberFileDto upload(MultipartFile file, Integer member_no) throws IOException{
		byte[] bytes = IOUtils.toByteArray(file.getInputStream());
		
		String originalName = file.getOriginalFilename();
		String uuid = getUUID(originalName);
		
		ObjectMetadata objectMetadata = new ObjectMetadata();
		objectMetadata.setContentLength(bytes.length);
		objectMetadata.setContentType(file.getContentType());
					
		// 요청 바디 작성
		PutObjectRequest putObjectRequest = new PutObjectRequest(this.bucket, getPath()+getUUID(originalName), file.getInputStream(), objectMetadata)
				.withCannedAcl(CannedAccessControlList.PublicRead);
		
		// s3에 저장
		this.s3Client.putObject(putObjectRequest);
		
		logger.info("upload complete! {}", putObjectRequest.getKey());
		
		String realPath = "https://"+this.bucket+".s3."+this.region+".amazonaws.com/"+putObjectRequest.getKey();			
		// https://usmarket.s3.ap-northeast-2.amazonaws.com/2023/01/24/2da9322b-f45f-428a-b1b3-bde87f88d052_IMG_5402.PNG
		
		MemberFileDto memberImage = new MemberFileDto(member_no, realPath, originalName, uuid);
			
		return memberImage;
	}

}
