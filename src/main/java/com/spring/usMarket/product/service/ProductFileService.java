package com.spring.usMarket.product.service;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
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
import com.spring.usMarket.product.controller.ProductController;
import com.spring.usMarket.product.domain.ProductFileDto;

@Service
@PropertySource("classpath:props/fileUpload.properties")
public class ProductFileService {
	private static final Logger logger = LoggerFactory.getLogger(ProductController.class);
	
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
	
	public List<ProductFileDto> upload(List<MultipartFile> file, String product_no) throws IOException{
		List<ProductFileDto> list = new ArrayList<>();
		
		int idx = 0;
		for(MultipartFile multipartFile : file) {			
			
			byte[] bytes = IOUtils.toByteArray(multipartFile.getInputStream());
			
			String originalName = multipartFile.getOriginalFilename();
			String uuid = getUUID(originalName);
			
			ObjectMetadata objectMetadata = new ObjectMetadata();
			objectMetadata.setContentLength(bytes.length);
			objectMetadata.setContentType(multipartFile.getContentType());
						
			// 요청 바디 작성
			PutObjectRequest putObjectRequest = new PutObjectRequest(this.bucket, getPath()+getUUID(originalName), multipartFile.getInputStream(), objectMetadata)
					.withCannedAcl(CannedAccessControlList.PublicRead);
			
			// s3에 저장
			this.s3Client.putObject(putObjectRequest);
			
			logger.info("upload complete! {}", putObjectRequest.getKey());
			
			String realPath = "https://"+this.bucket+".s3."+this.region+".amazonaws.com/"+putObjectRequest.getKey();			
			// https://usmarket.s3.ap-northeast-2.amazonaws.com/2023/01/24/2da9322b-f45f-428a-b1b3-bde87f88d052_IMG_5402.PNG
			
			ProductFileDto productFileDto = new ProductFileDto(product_no, realPath, originalName, uuid, idx);
			list.add(productFileDto);
			
			idx++;
		}
		return list;
	}	

}
