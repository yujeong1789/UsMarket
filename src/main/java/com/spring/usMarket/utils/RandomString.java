package com.spring.usMarket.utils;

import java.text.SimpleDateFormat;
import java.util.Date;

public class RandomString {
	public static final String yyyyMMdd = "yyyyMMdd";
	public static final String yyyyMMddHHmm = "yyyyMMddHHmm";
	public static final String yyyyMMddHHmmss = "yyyyMMddHHmmss";
	
	public static String getRandomString(String format, int length) {
		Date date = new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat(format);
		String result = dateFormat.format(date);
		
		for(int i = 0; i < length; i++) {
			char tmp = (char)((int)(Math.random() * 25) + 65);
			result += tmp;
		}
		
		return result;
	}
}
