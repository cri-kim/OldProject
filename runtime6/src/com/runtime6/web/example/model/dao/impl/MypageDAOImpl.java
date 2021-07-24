package com.runtime6.web.example.model.dao.impl;


import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.stereotype.Repository;

import com.runtime6.web.example.model.dao.MypageDAO;
import com.runtime6.web.example.model.dto.Join;
import com.runtime6.web.example.model.dto.JoinParam;
import com.runtime6.web.example.model.dto.Post;
import com.runtime6.web.example.model.dto.PostParam;

@Repository
public class MypageDAOImpl extends SqlSessionDaoSupport implements MypageDAO {
	
	@SuppressWarnings("unchecked")
	public List<Join> getMypageUserList(JoinParam param) {
		return getSqlSession().selectList("com.runtime6.web.example.model.mapper.Mypage.getMypageUserList",param);		
	}
	
	@Override
	public int getCountMypageUserList(JoinParam param) {
		return (Integer)getSqlSession().selectOne("com.runtime6.web.example.model.mapper.Mypage.getCountMypageUserList",param);
	}
	
	@Override
	public int stopForcedUser(JoinParam param) {
		return getSqlSession().update(
				"com.runtime6.web.example.model.mapper.Mypage.stopForcedUser",param);
	}

	

	@Override
	public Join getMyinfor(JoinParam param) {
		return (Join) getSqlSession().selectOne("com.runtime6.web.example.model.mapper.Mypage.getMyinfor", param);
	}

	@Override
	public int updateUserinfor(JoinParam param) {
		return getSqlSession().update("com.runtime6.web.example.model.mapper.Mypage.updateUserinfor",param);
	}

	@Override
	public int updateProviderinfor(JoinParam param) {
		return getSqlSession().update("com.runtime6.web.example.model.mapper.Mypage.updateProviderinfor",param);
	}

	@Override
	public int stopUser(JoinParam param) {
		return getSqlSession().update("com.runtime6.web.example.model.mapper.Mypage.stopUser",param);
	}

	
	
	@Override
	public List<Join> getBuyList(JoinParam param) {
		return getSqlSession().selectList("com.runtime6.web.example.model.mapper.Mypage.getBuyList",param);		
	}

	@Override
	public int getCountBuyList(JoinParam param) {
		return (Integer)getSqlSession().selectOne("com.runtime6.web.example.model.mapper.Mypage.getCountBuyList",param);
	}

	@Override
	public List<Join> getSellList(JoinParam param) {
		return getSqlSession().selectList("com.runtime6.web.example.model.mapper.Mypage.getSellList",param);	
	}

	@Override
	public int getCountSellList(JoinParam param) {
		return (Integer)getSqlSession().selectOne("com.runtime6.web.example.model.mapper.Mypage.getCountSellList",param);
	}

	
}
