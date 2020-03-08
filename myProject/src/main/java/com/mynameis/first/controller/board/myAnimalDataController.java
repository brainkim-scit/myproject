package com.mynameis.first.controller.board;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.mynameis.first.dao.board.myAnimalDataDAO;
import com.mynameis.first.util.PageNavigator;
import com.mynameis.first.vo.myAnimalVO;

@RestController
public class myAnimalDataController {
	
	@Autowired
	myAnimalDataDAO dao;
	
	private static final Logger logger = LoggerFactory.getLogger(myAnimalDataController.class);
	
	@PostMapping("/myAnimalSend")
	public int myAnimalInsert(myAnimalVO animal, HttpSession session) {
		logger.info("내 관심 동물 등록 : "+animal.toString());
		return dao.myAnimalInsert(animal, session);
	}
	
	@PostMapping("/myAnimalDelete")
	public int myAnimalDelete(myAnimalVO animal, HttpSession session) {
		logger.info("내 관심 동물 삭제 : "+animal.toString());
		return dao.myAnimalDelete(animal, session);
	}
	
	@GetMapping("/savedCheck")
	public int savedCheck(myAnimalVO animal, HttpSession session) {
		logger.info("내 관심 동물 존재 확인 : "+animal.toString());
		return dao.savedCheck(animal, session);
	}
	
	@GetMapping("/myAnimalList")
	public Map<String, Object> myAnimalDelete(
			@RequestParam(value = "currentPage", defaultValue = "1")int currentPage,
			HttpSession session) {
		Map<String, Object> map = new HashMap<String, Object>();
		logger.info("내 관심 동물 리스트 불러오기");
		int totalRecordCount = dao.myAnimalCount(session);
		PageNavigator navi = new PageNavigator(currentPage, totalRecordCount);
		ArrayList<myAnimalVO> list = dao.listAll(navi,session);
		map.put("navi", navi);
		map.put("list", list);
		return map;
	}
	
	@GetMapping("/careAddress")
	public ArrayList<myAnimalVO> careAddressList(HttpSession session){
		logger.info("보호소 정보 리스트 불러오기");
		return dao.careAddress(session);
	}
}
