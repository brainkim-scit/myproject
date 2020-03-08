package com.mynameis.first.controller.member;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mynameis.first.dao.member.memberDAO;
import com.mynameis.first.vo.myMemberVO;

@Controller
public class memberController {

	@Autowired
	memberDAO dao;
	
	private static final Logger logger = LoggerFactory.getLogger(memberController.class);
	
	@GetMapping("/login")
	public String loginView() {
		logger.info("login 이동");
		return "member/login";
	}
	
	@PostMapping("/login")
	public String login(myMemberVO member, RedirectAttributes rttr, HttpSession session) {
		logger.info("login 시도 -> "+member.toString());
		myMemberVO result = dao.selectMember(member);
		if(result == null) {
			rttr.addFlashAttribute("loginResult", false);
			logger.info("로그인 실패");
			return "redirect:/login";
		}else {
			logger.info("로그인 성공");
			session.setAttribute("loginId", member.getEmail());
			session.setAttribute("code", result.getSigungucode());
			return "redirect:/";
		}
	}
	
	@GetMapping("/signup")
	public String signupView() {
		logger.info("회원가입 화면 이동");
		return "member/signup";
	}
	
	@PostMapping("/signup")
	public String signup(myMemberVO member, RedirectAttributes rttr) {
		logger.info("회원가입 시도 -> "+member.toString());
		int result = dao.insertMember(member);
		if(result == 0) {
			logger.info("회원가입 실패");
			rttr.addFlashAttribute("signupResult", false);
			return "redirect:/signup";
		}else {
			logger.info("회원가입 성공");
			rttr.addFlashAttribute("signupResult", true);
			return "redirect:/";
		}
	}
	
	@GetMapping("/mypage")
	public String myPageView(HttpSession session, Model model) {
		myMemberVO member= new myMemberVO();
		String email = (String) session.getAttribute("loginId");
		member.setEmail(email);
		logger.info("마이 페이지 : "+member.toString());
		model.addAttribute("user", dao.selectMember(member));
		return "member/myPage";
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		logger.info("로그아웃");
		session.invalidate();
		return "redirect:/";
	}
	
	
	@GetMapping("/byebye")
	public String byebye(HttpSession session, myMemberVO member, RedirectAttributes rttr) {
		logger.info("회원탈퇴 : "+member.toString());
		String email = (String) session.getAttribute("loginId");
		member.setEmail(email);
		session.invalidate();
		int result = dao.deleteMember(member);
		if(result == 1) {
			rttr.addFlashAttribute("byebye", true);
		}else {
			rttr.addFlashAttribute("byebye", false);
		}
		return "redirect:/";
	}
}
