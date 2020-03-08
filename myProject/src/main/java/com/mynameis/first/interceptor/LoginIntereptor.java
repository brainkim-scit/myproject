package com.mynameis.first.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginIntereptor extends HandlerInterceptorAdapter {
	
	private static final Logger logger = LoggerFactory.getLogger(LoginIntereptor.class);

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		logger.info("로그인 인터셉터");
		String loginId = (String) request.getSession().getAttribute("loginId");
		if(loginId == null) {
			String contextPath = request.getContextPath();
			response.sendRedirect(contextPath+"/login");
			return false;
		}else return true;
	}
}
