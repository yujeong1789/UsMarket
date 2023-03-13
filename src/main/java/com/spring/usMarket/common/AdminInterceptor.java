package com.spring.usMarket.common;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.HandlerInterceptor;

public class AdminInterceptor implements HandlerInterceptor{

	private static final Logger logger = LoggerFactory.getLogger(AdminInterceptor.class);
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		HttpSession session = request.getSession();
		if(session.getAttribute("admin") == null) {
			String path = request.getRequestURL().substring(0, request.getRequestURL().length()-request.getServletPath().length());
			logger.info("path = {}", path);
			response.sendRedirect(path+"/admin/login");
			
			return false;
		}
		
		return true;
	}
}
