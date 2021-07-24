package com.runtime6.web.example.model.dao.impl;

import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.stereotype.Repository;

import com.runtime6.web.example.model.dao.FreeboardDAO;
import com.runtime6.web.example.model.dto.FB_Post;
import com.runtime6.web.example.model.dto.FB_PostParam;


@Repository
public class FreeboardDAOImpl extends SqlSessionDaoSupport implements FreeboardDAO {

	@SuppressWarnings("unchecked")
	public List<FB_Post> getPostList(FB_PostParam param) {
		return getSqlSession()
				.selectList("com.runtime6.web.example.model.mapper.Freeboard.getPostList"
				,param);

	}

	public FB_Post getPost(FB_PostParam param) {
		return (FB_Post)getSqlSession().selectOne(
				"com.runtime6.web.example.model.mapper.Freeboard.getPost", param);

	}
	@Override
	public int deletePost(FB_PostParam postParam) {
		return getSqlSession().delete(
				"com.runtime6.web.example.model.mapper.Freeboard.deletePost",postParam);

	}
	
	@Override
	public int updatePost(FB_PostParam postParam) {
		return getSqlSession().update("com.runtime6.web.example.model.mapper.Freeboard.updatePost",postParam);
	}

	@Override
	public int insertPost(FB_Post post) {
		System.out.println("등록");
		return getSqlSession().insert(
				"com.runtime6.web.example.model.mapper.Freeboard.insertPost",
				post);

	}
	@Override
	public int insertAttachFile(FB_Post post) {
		return getSqlSession().update(
				"com.runtime6.web.example.model.mapper.Freeboard.insertAttachFile",
				post);

	}

	@Override
	public int getCountPostList(FB_PostParam param) {
		return (Integer)getSqlSession().selectOne(
				"com.runtime6.web.example.model.mapper.Freeboard.getCountPostList", param);
	}
}