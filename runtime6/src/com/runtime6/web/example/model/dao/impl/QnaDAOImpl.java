package com.runtime6.web.example.model.dao.impl;

import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.stereotype.Repository;

import com.runtime6.web.example.model.dao.QnaDAO;
import com.runtime6.web.example.model.dto.QnaPost;
import com.runtime6.web.example.model.dto.QnaPostParam;


@Repository
public class QnaDAOImpl extends SqlSessionDaoSupport implements QnaDAO {

	@SuppressWarnings("unchecked")
	public List<QnaPost> getPostList(QnaPostParam param) {
		return getSqlSession()
				.selectList("com.runtime6.web.example.model.mapper.Qna.getPostList"
				,param);

	}

	public QnaPost getPost(QnaPostParam param) {
		return (QnaPost)getSqlSession().selectOne(
				"com.runtime6.web.example.model.mapper.Qna.getPost", param);

	}
	@Override
	public int deletePost(QnaPostParam postParam) {
		return getSqlSession().delete(
				"com.runtime6.web.example.model.mapper.Qna.deletePost",postParam);

	}
	
	
	@Override
	public int updatePost(QnaPostParam postParam) {
		return getSqlSession().update(
				"com.runtime6.web.example.model.mapper.Qna.updatePost",
				postParam);

	}
	@Override
	public int insertPost(QnaPost post) {
		System.out.println("등록");
		return getSqlSession().insert(
				"com.runtime6.web.example.model.mapper.Qna.insertPost",
				post);

	}
	@Override
	public int replyPost(QnaPost post) {
		System.out.println("등록");
		return getSqlSession().insert(
				"com.runtime6.web.example.model.mapper.Qna.replyPost",
				post);

	}
	@Override
	public int getCountPostList(QnaPostParam param) {
		return (Integer)getSqlSession().selectOne(
				"com.runtime6.web.example.model.mapper.Qna.getCountPostList", param);
	}

	@Override
	public int replyPostenabled(QnaPost post) {
		return getSqlSession().insert(
				"com.runtime6.web.example.model.mapper.Qna.replyPostenabled",
				post);
	}
}