package com.runtime6.web.example.model.dao.impl;

import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.stereotype.Repository;

import com.runtime6.web.example.model.dao.BCommentDAO;
import com.runtime6.web.example.model.dao.CommentDAO;
import com.runtime6.web.example.model.dto.BComment;
import com.runtime6.web.example.model.dto.BCommentParam;

@Repository
public class BCommentDAOImpl  extends SqlSessionDaoSupport implements BCommentDAO{

	@Override
	public List<BComment> getBCommentList(BCommentParam param) {
		return getSqlSession().selectList(
				"com.runtime6.web.example.model.mapper.BComment.getBCommentList"
				,param);
	}

	@Override
	public int deleteBCommentByItem_no(String item_no) {
		return getSqlSession().delete(
				"com.runtime6.web.example.model.mapper.BComment.deleteBCommentByItem_no"
				,item_no);
	}

	@Override
	public int deleteBComment(String cmt_num) {
		return getSqlSession().delete(
				"com.runtime6.web.example.model.mapper.BComment.deleteBComment"
				,cmt_num);
	}

	@Override
	public int updateBComment(BComment bcomment) {
		return getSqlSession().update(
				"com.runtime6.web.example.model.mapper.BComment.updateBComment"
				,bcomment);
	}

	@Override
	public int insertBComment(BComment bcomment) {
		return getSqlSession().insert(
				"com.runtime6.web.example.model.mapper.BComment.insertBComment"
				,bcomment);
	}

}
