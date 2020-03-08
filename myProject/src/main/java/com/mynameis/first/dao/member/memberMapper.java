package com.mynameis.first.dao.member;

import com.mynameis.first.vo.myMemberVO;

public interface memberMapper {

	public int insertMember(myMemberVO member);
	public myMemberVO selectMember(myMemberVO member);
	public int updateMember(myMemberVO member);
	public int deleteMember(myMemberVO member);
}
