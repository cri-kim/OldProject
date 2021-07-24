package com.runtime6.web.example.model.dao;

import java.util.List;

import com.runtime6.web.example.model.dto.BComment;
import com.runtime6.web.example.model.dto.BCommentParam;

public interface BCommentDAO {
	public List<BComment> getBCommentList(BCommentParam param);
	
	public int deleteBCommentByItem_no(String item_no);
	
	public int deleteBComment(String cmt_num);

	public int updateBComment(BComment bcomment);
	
	public int insertBComment(BComment bcomment);
}
