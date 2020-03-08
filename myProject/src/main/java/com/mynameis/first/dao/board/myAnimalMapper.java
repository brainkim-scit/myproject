package com.mynameis.first.dao.board;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;

import com.mynameis.first.vo.myAnimalVO;

public interface myAnimalMapper {
	
	public int myAnimalInsert(myAnimalVO animal);
	public int myAnimalDelete(myAnimalVO animal);
	public int myAnimalCount(String email);
	public ArrayList<myAnimalVO> careAddress(String email);
	public int savedCheck(myAnimalVO animal);
	public ArrayList<myAnimalVO> listAll(String email, RowBounds rb);
}
