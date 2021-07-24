package com.runtime6.web.example.model.dao.impl;

import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.stereotype.Repository;

import com.runtime6.web.example.model.dao.BbsDAO;
import com.runtime6.web.example.model.dto.Post;
import com.runtime6.web.example.model.dto.PostParam;


@Repository
public class BbsDAOImpl extends SqlSessionDaoSupport implements BbsDAO {

	@SuppressWarnings("unchecked")
	public List<Post> getPostList(PostParam param) {
		return getSqlSession()
				.selectList("com.runtime6.web.example.model.mapper.Bbs.getPostList"
				,param);

	}

	public Post getPost(PostParam param) {
		return (Post)getSqlSession().selectOne(
				"com.runtime6.web.example.model.mapper.Bbs.getPost", param);

	}
	@Override
	public int deletePost(PostParam postParam) {
		return getSqlSession().delete(
				"com.runtime6.web.example.model.mapper.Bbs.deletePost",postParam);

	}
	
	
	@Override
	public int updatePost(PostParam postParam) {
		return getSqlSession().update(
				"com.runtime6.web.example.model.mapper.Bbs.updatePost",
				postParam);

	}
	@Override
	public int insertPost(Post post) {
		System.out.println("등록");
		return getSqlSession().insert(
				"com.runtime6.web.example.model.mapper.Bbs.insertPost",
				post);

	}
	@Override
	public int insertAttachFile(Post post) {
		return getSqlSession().update(
				"com.runtime6.web.example.model.mapper.Bbs.insertAttachFile",
				post);

	}

	@Override
	public int getCountPostList(PostParam param) {
		return (Integer)getSqlSession().selectOne(
				"com.runtime6.web.example.model.mapper.Bbs.getCountPostList", param);
	}
}