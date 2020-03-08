package com.mynameis.first.dao.reply;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mynameis.first.controller.reply.animalReplyController;
import com.mynameis.first.dao.member.memberDAO;
import com.mynameis.first.util.PageNavigator;
import com.mynameis.first.util.PageNavigator2;
import com.mynameis.first.vo.animalReplyVO;
import com.mynameis.first.vo.myMemberVO;

@Repository
public class animalReplyDAO {
	
	@Autowired
	memberDAO dao;
	
	@Autowired
	SqlSession session;
	
	private static final Logger logger = LoggerFactory.getLogger(animalReplyDAO.class);
	
	public ArrayList<animalReplyVO> listAll(animalReplyVO animalReply, PageNavigator2 navi) {
		animalReplyMapper mapper = session.getMapper(animalReplyMapper.class);
		RowBounds rb = new RowBounds(navi.getStartRecord(), navi.getCountPerPage());
		return mapper.listAll(animalReply,rb);
	}
	
	public int replyCount(animalReplyVO animalReply) {
		animalReplyMapper mapper = session.getMapper(animalReplyMapper.class);
		return mapper.replyCount(animalReply);
	}
	
	public int replyInsert(animalReplyVO animalReply, HttpSession httpsession) {
		myMemberVO member = new myMemberVO();
		String loginId = (String) httpsession.getAttribute("loginId");
		member.setEmail(loginId);
		String username = dao.selectMember(member).getUsername();
		animalReply.setEmail(loginId);
		animalReply.setUsername(username);
		logger.info(loginId+" "+username);
		logger.info("댓글 입력 : "+animalReply.toString());
		animalReplyMapper mapper = session.getMapper(animalReplyMapper.class);
		return mapper.replyInsert(animalReply);
	}
	
	public int replyDelete(animalReplyVO animalReply, HttpSession httpsession) {
		String loginId = (String) httpsession.getAttribute("loginId");
		animalReply.setEmail(loginId);
		animalReplyMapper mapper = session.getMapper(animalReplyMapper.class);
		return mapper.replyDelete(animalReply);
	}
	
	public int replyModify(animalReplyVO animalReply, HttpSession httpsession) {
		String loginId = (String) httpsession.getAttribute("loginId");
		animalReply.setEmail(loginId);
		animalReplyMapper mapper = session.getMapper(animalReplyMapper.class);
		return mapper.replyModify(animalReply);
	}

}
