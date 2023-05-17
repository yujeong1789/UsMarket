package com.spring.usMarket.handler;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.services.s3.AmazonS3Client;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;

@Configuration 
@EnableWebMvc
@PropertySource("classpath:props/fileUpload.properties")
public class AWSConfiguration implements WebMvcConfigurer{
 	@Value("${cloud.aws.credentials.accessKey}")
	private String accessKey;
	
	@Value("${cloud.aws.credentials.secretKey}")
	private String secretKey;
	
	@Value("${cloud.aws.region}")
	private String region;
	
	@Bean
	public AmazonS3Client awsS3Client() {
		BasicAWSCredentials awsCredentials = new BasicAWSCredentials(accessKey, secretKey);
		AmazonS3Client s3Builder = (AmazonS3Client)AmazonS3ClientBuilder.standard()
									.withRegion(region)
									.withCredentials(new AWSStaticCredentialsProvider(awsCredentials))
									.build();
		 
		return s3Builder;
	}
}
