package com.mynameis.first.dao.board;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.mynameis.first.util.PageNavigator;
import com.mynameis.first.vo.myAnimalVO;

@Repository
public class myAnimalDataDAO {

	
	@Autowired
	SqlSession session;
	
	public int myAnimalInsert(myAnimalVO animal, HttpSession httpsession) {
		myAnimalMapper mapper = session.getMapper(myAnimalMapper.class);
		String loginId = (String) httpsession.getAttribute("loginId");
		animal.setEmail(loginId);
		return mapper.myAnimalInsert(animal);
	}
	
	public int myAnimalDelete(myAnimalVO animal, HttpSession httpsession) {
		myAnimalMapper mapper = session.getMapper(myAnimalMapper.class);
		String loginId = (String) httpsession.getAttribute("loginId");
		animal.setEmail(loginId);
		return mapper.myAnimalDelete(animal);
	}
	
	public int savedCheck(myAnimalVO animal, HttpSession httpsession) {
		myAnimalMapper mapper = session.getMapper(myAnimalMapper.class);
		String loginId = (String) httpsession.getAttribute("loginId");
		animal.setEmail(loginId);
		return mapper.savedCheck(animal);
	}
	
	public ArrayList<myAnimalVO> listAll(PageNavigator navi,HttpSession httpsession) {
		myAnimalMapper mapper = session.getMapper(myAnimalMapper.class);
		String email = (String) httpsession.getAttribute("loginId");
		RowBounds rb = new RowBounds(navi.getCurrentPage(), navi.getCountPerPage());
		return mapper.listAll(email, rb);
	}
	
	public int myAnimalCount(HttpSession httpsession) {
		myAnimalMapper mapper = session.getMapper(myAnimalMapper.class);
		String email = (String) httpsession.getAttribute("loginId");
		return mapper.myAnimalCount(email);
	}
	
	public ArrayList<myAnimalVO> careAddress(HttpSession httpsession){
		myAnimalMapper mapper = session.getMapper(myAnimalMapper.class);
		String email = (String) httpsession.getAttribute("loginId");
		return mapper.careAddress(email);
	}
}
