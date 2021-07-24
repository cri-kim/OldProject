package com.runtime6.web.example.model.dao.impl;

import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.stereotype.Repository;

import com.runtime6.web.example.model.dao.CommentDAO;
import com.runtime6.web.example.model.dto.Comment;
import com.runtime6.web.example.model.dto.CommentParam;
@Repository
public class CommentDAOImpl extends SqlSessionDaoSupport implements CommentDAO {
	@SuppressWarnings("unchecked")
	@Override
	public List<Comment> getCommentList(CommentParam commentParam) {
		return getSqlSession().selectList(
				"com.runtime6.web.example.model.mapper.Comment.getCommentList"
				,commentParam);
	}
	
	@Override
	public int deleteComment(String cmt_Num) {
		return getSqlSession().delete(
				"com.runtime6.web.example.model.mapper.Comment.deleteComment"
				,cmt_Num);
	}

	@Override
	public int updateComment(Comment comment) {
		return getSqlSession().update(
				"com.runtime6.web.example.model.mapper.Comment.updqteComment"
				,comment);
	}

	@Override
	public int insertComment(Comment comment) {
		return getSqlSession().insert(
				"com.runtime6.web.example.model.mapper.Comment.insertComment"
				,comment);
	}

	@Override
	public int deleteCommentByB_id(String b_id) {
		return getSqlSession().delete(
				"com.runtime6.web.example.model.mapper.Comment.deleteCommentByB_id"
				,b_id);
	}
}
