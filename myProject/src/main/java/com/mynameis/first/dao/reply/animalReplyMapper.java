package com.mynameis.first.dao.reply;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;

import com.mynameis.first.vo.animalReplyVO;

public interface animalReplyMapper {

	public int replyInsert(animalReplyVO animalReply);
	public int replyDelete(animalReplyVO animalReply);
	public int replyModify(animalReplyVO animalReply);
	public ArrayList<animalReplyVO> listAll(animalReplyVO animalReplyVO, RowBounds rb);
	public int replyCount(animalReplyVO animalReply);
}
