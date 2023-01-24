package com.spring.usMarket.common;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.amazonaws.auth.AWSStaticCredentialsProvider;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.regions.Regions;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3ClientBuilder;

@Configuration 
@EnableWebMvc
@PropertySource("classpath:props/fileUpload.properties")
public class AWSConfiguration implements WebMvcConfigurer{
 	@Value("${cloud.aws.credentials.accessKey}")
	private String accessKey;
	
	@Value("${cloud.aws.credentials.secretKey}")
	private String secretKey;
	
	@Bean
	public BasicAWSCredentials awsCredentials() {
		BasicAWSCredentials awsCredentials = new BasicAWSCredentials(accessKey, secretKey);
		return awsCredentials;
	}
	
	@Bean
	public AmazonS3 awsS3Client() {
		 AmazonS3 s3Builder = AmazonS3ClientBuilder.standard()
									.withRegion(Regions.AP_NORTHEAST_2)
									.withCredentials(new AWSStaticCredentialsProvider(this.awsCredentials()))
									.build();
		 
		 return s3Builder;
	}
}
