package com.mynameis.first.controller.member;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
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
	
	@PostMapping("/pwCheck")
	public String pwCheck(HttpSession session, myMemberVO member) {
		String email = (String) session.getAttribute("loginId");
		member.setEmail(email);
		logger.info("비밀번호 변경 체크 : "+member.toString());
		if(dao.selectMember(member) == null) {
			return "fail";
		}else return "success";
	}
	
	@PostMapping("/goModify")
	public int goModify(HttpSession session, myMemberVO member) {
		logger.info("회원정보 변경 : "+member.toString());
		String email = (String) session.getAttribute("loginId");
		member.setEmail(email);
		return dao.updateMember(member);
	}
}
