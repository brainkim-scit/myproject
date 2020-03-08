package com.mynameis.first.util;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class paging {

	private static final Logger logger = LoggerFactory.getLogger(paging.class);
	
	@GetMapping("/paging")
	public PageNavigator pagingNaviOut(
			int totalRecordCount,
			int currentPage
			) {
		PageNavigator navi = new PageNavigator(currentPage, totalRecordCount);
		logger.info("페이징 네비 보내기 : "+navi.toString());
		return navi;
	}
}
