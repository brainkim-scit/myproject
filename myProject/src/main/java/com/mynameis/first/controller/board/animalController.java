package com.mynameis.first.controller.board;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.mynameis.first.dao.member.memberDAO;
import com.mynameis.first.vo.myAnimalVO;
import com.mynameis.first.vo.myMemberVO;


@Controller
public class animalController {

	private static final Logger logger = LoggerFactory.getLogger(animalController.class);
	
	@Autowired
	memberDAO dao;
	
	@GetMapping("/around")
	public String aroundView(HttpSession session) {
		logger.info("around 이동");
		session.removeAttribute("page");
		session.removeAttribute("date");
		session.removeAttribute("sidocode");
		session.removeAttribute("sigungucode");
		return "board/around/around";
	}
	
	@GetMapping("/outer")
	public String outerView(HttpSession session) {
		logger.info("around 이동");
		session.removeAttribute("page");
		session.removeAttribute("date");
		session.removeAttribute("sidocode");
		session.removeAttribute("sigungucode");
		return "board/outer/outer";
	}
	
	@GetMapping("/detail")
	public String detailView(myAnimalVO vo, String fromWhere, Model model) {
		logger.info("Detail 이동" + vo);
		logger.info("from where "+fromWhere);
		model.addAttribute("vo", vo);
		model.addAttribute("fromWhere", fromWhere);
		return "board/boardDetail";
	}

	@GetMapping("/myAnimal")
	public String myAnimalView(HttpSession session) {
		logger.info("myAnimal 이동");
		session.removeAttribute("page");
		session.removeAttribute("date");
		session.removeAttribute("sidocode");
		session.removeAttribute("sigungucode");
		return "board/myAnimals";
	}
	
	
	
	
	
	@GetMapping("/aroundCat")
	public String aroundCat(Model model) {
		logger.info("aroundCat 이동");
		model.addAttribute("type", "422400");
		return "board/around/aroundCat";
	}
	
	@GetMapping("/aroundDog")
	public String aroundDog(Model model) {
		logger.info("aroundDog 이동");
		model.addAttribute("type", "417000");
		return "board/around/aroundDog";
	}
	
	@GetMapping("/aroundEtc")
	public String aroundEtc(Model model) {
		logger.info("aroundEtc 이동");
		model.addAttribute("type", "429900");
		return "board/around/aroundEtc";
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	@GetMapping("/outerCat")
	public String outerCat(Model model, HttpSession session) {
		logger.info("outerCat 이동");
		model.addAttribute("type", "422400");
		myMemberVO member = new myMemberVO();
		String email = (String) session.getAttribute("loginId");
		member.setEmail(email);
		model.addAttribute("sgcode",dao.selectMember(member).getSigungucode());
		return "board/outer/outerCat";
	}
	
	@GetMapping("/outerDog")
	public String outerDog(Model model, HttpSession session) {
		logger.info("outerDog 이동");
		model.addAttribute("type", "417000");
		myMemberVO member = new myMemberVO();
		String email = (String) session.getAttribute("loginId");
		member.setEmail(email);
		model.addAttribute("sgcode",dao.selectMember(member).getSigungucode());
		return "board/outer/outerDog";
	}
	
	@GetMapping("/outerEtc")
	public String outerEtc(Model model, HttpSession session) {
		logger.info("outerEtc 이동");
		model.addAttribute("type", "429900");
		myMemberVO member = new myMemberVO();
		String email = (String) session.getAttribute("loginId");
		member.setEmail(email);
		model.addAttribute("sgcode",dao.selectMember(member).getSigungucode());
		return "board/outer/outerEtc";
	}
}
