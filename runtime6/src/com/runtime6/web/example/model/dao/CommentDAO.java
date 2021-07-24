package com.runtime6.web.example.model.dao;

import java.util.List;

import com.runtime6.web.example.model.dto.Comment;
import com.runtime6.web.example.model.dto.CommentParam;

public interface CommentDAO {

//	public Comment getComment(CommentParam commentParam);
	
	public List<Comment> getCommentList(CommentParam commentParam);
	
	public int deleteCommentByB_id(String b_id);
	
	public int deleteComment(String cmt_Num);

	public int updateComment(Comment comment);
	
	public int insertComment(Comment comment);
}
