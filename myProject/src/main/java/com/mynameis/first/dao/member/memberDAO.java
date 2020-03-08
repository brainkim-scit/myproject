package com.mynameis.first.dao.member;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mynameis.first.vo.myMemberVO;

@Repository
public class memberDAO {

	private static final Logger logger = LoggerFactory.getLogger(memberDAO.class);
	
	@Autowired
	SqlSession session;
	
	public int insertMember(myMemberVO member) {
		memberMapper mapper = session.getMapper(memberMapper.class);
		int result = mapper.insertMember(member);
		logger.info("insertMember 결과 : "+result);
		return result;
	};
	
	public int deleteMember(myMemberVO member) {
		memberMapper mapper = session.getMapper(memberMapper.class);
		int result = mapper.deleteMember(member);
		logger.info("deleteMember 결과 : "+result);
		return result;
	};
	
	public int updateMember(myMemberVO member) {
		memberMapper mapper = session.getMapper(memberMapper.class);
		int result = mapper.updateMember(member);
		logger.info("updateMember 결과 : "+result);
		return result;
	};
	
	public myMemberVO selectMember(myMemberVO member) {
		memberMapper mapper = session.getMapper(memberMapper.class);
		myMemberVO result = mapper.selectMember(member);
		logger.info("selectMember 결과 : "+result);
		return result;
	}
}
