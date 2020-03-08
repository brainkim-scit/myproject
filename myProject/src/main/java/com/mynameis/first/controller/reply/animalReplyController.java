package com.mynameis.first.controller.reply;

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

import com.mynameis.first.dao.reply.animalReplyDAO;
import com.mynameis.first.util.PageNavigator2;
import com.mynameis.first.vo.animalReplyVO;

@RestController
public class animalReplyController {
	
	private static final Logger logger = LoggerFactory.getLogger(animalReplyController.class);

	@Autowired
	animalReplyDAO dao;
	
	@GetMapping("/animalReplyList")
	public Map<String, Object> listAll(
			animalReplyVO animalReply,
			@RequestParam(value = "currentPage", defaultValue = "1")String currentPage) {
		logger.info("내 구역 동물 댓글 리스트 출력 : "+currentPage+"페이지");
		Map<String, Object> map = new HashMap<String, Object>();
		int totalRecordCount = dao.replyCount(animalReply);
		PageNavigator2 navi = new PageNavigator2(Integer.parseInt(currentPage), totalRecordCount);
		map.put("list", dao.listAll(animalReply, navi));
		map.put("navi",navi);
		
		return map;
	}
	
	@PostMapping("/insertAnimalReply")
	public int replyInsert(animalReplyVO animalReply, HttpSession session) {
		logger.info("동물 댓글 입력 : "+animalReply.toString());
		return dao.replyInsert(animalReply, session);
	}
	
	@PostMapping("/deleteAnimalReply")
	public int replyDelete(animalReplyVO animalReply, HttpSession session) {
		logger.info("동물 댓글 삭제 : "+animalReply.toString());
		return dao.replyDelete(animalReply, session);
	}

	@PostMapping("/modifyAnimalReply")
	public int replyModify(animalReplyVO animalReply, HttpSession session) {
		logger.info("동물 댓글 수정 : "+animalReply.toString());
		return dao.replyModify(animalReply, session);
	};
}
