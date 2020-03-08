package com.mynameis.first.controller.member;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.mynameis.first.dao.member.memberDAO;
import com.mynameis.first.vo.myMemberVO;

@RestController
public class memberDataController {

	@Autowired
	memberDAO dao;
	
	private static final Logger logger = LoggerFactory.getLogger(memberDataController.class);
	
	@GetMapping("/idCheck")
	public String idCheck(myMemberVO member) {
		logger.info("중복확인 : "+ member.toString());
		myMemberVO check = dao.selectMember(member);
		if(check != null) {
			return "yes";
		}else {
			return "no";
		}
	}
}
