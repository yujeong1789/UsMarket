package com.spring.usMarket.utils;

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
}
