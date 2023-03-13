package com.spring.usMarket.utils;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public class SessionParameters {
	
	public static String getUserNo(HttpServletRequest request) {
		String userNo = String.valueOf(request.getSession().getAttribute("userNo")); 
        return userNo;
    }
	
	public static String getUserId(HttpServletRequest request) {
		String userId = String.valueOf(request.getSession().getAttribute("userId"));
		return userId;
	}

	@SuppressWarnings("unchecked")
	public static Map<String, Object> getAdmin(HttpServletRequest request) {
		return (Map<String, Object>)request.getSession().getAttribute("admin");
	}
}
