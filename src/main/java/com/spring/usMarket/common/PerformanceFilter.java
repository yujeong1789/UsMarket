package com.spring.usMarket.common;

import java.io.IOException;


import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebFilter(urlPatterns={"/*"})
public class PerformanceFilter implements Filter {
	private static final String excludeUrls= "/resources";
	
	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		// 초기화 작업
		System.out.println("PerformanceFilter called()");
	}

	@Override
	public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
			throws IOException, ServletException {
		
		HttpServletRequest request=(HttpServletRequest)req;
		HttpServletResponse response=(HttpServletResponse)res;
		
		long startTime = System.currentTimeMillis();

		chain.doFilter(request, response);
		
		String path=request.getRequestURI().substring(request.getContextPath().length());
		if (!path.startsWith(excludeUrls)) {
			
			String referer=request.getHeader("referer"); //어디서 요청했는지 알 수 있음
			String method=request.getMethod();
			
			// 요청 흐름 print
			System.out.print("["+referer+"] -> "+method+"["+request.getRequestURI()+"]");
			System.out.println(" 소요시간="+(System.currentTimeMillis()-startTime)+"ms");
		}
	}

	@Override
	public void destroy() {
		// 정리 작업
	}
}