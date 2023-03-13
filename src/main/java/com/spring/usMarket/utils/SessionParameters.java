package com.spring.usMarket.utils;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

public class SessionParameters {
	
	public static String getUserNo(HttpServletRequest request) { 
        return (String) request.getSession().getAttribute("userNo");
    }
	
	public static String getUserId(HttpServletRequest request) {
		return (String) request.getSession().getAttribute("userId");
	}
	
	@SuppressWarnings("unchecked")
	public static Map<String, Object> getAdmin(HttpServletRequest request) {
		return (Map<String, Object>)request.getSession().getAttribute("admin");
	}
}
