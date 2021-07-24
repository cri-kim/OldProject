package com.runtime6.web.example.model.dao.impl;

import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.stereotype.Repository;

import com.runtime6.web.example.model.dao.HomeDAO;
import com.runtime6.web.example.model.dto.Business;
import com.runtime6.web.example.model.dto.BusinessParam;

@Repository
public class HomeDAOImpl extends SqlSessionDaoSupport implements HomeDAO{
	
	@SuppressWarnings("unchecked")
	public List<Business> getHomeList(BusinessParam param) {
		System.out.println("homedaoimpl getHomeList진입");
		return getSqlSession().selectList("com.runtime6.web.example.model.mapper.Home.getHomeList",param);
	}
	@SuppressWarnings("unchecked")
	public List<Business> getHomeList2(BusinessParam param) {
		System.out.println("homedaoimpl getHomeList2진입");
		return getSqlSession().selectList("com.runtime6.web.example.model.mapper.Home.getHomeList2",param);
	}
	public Business getHome(BusinessParam param){
		System.out.println("homedaoimpl getHome진입");
		return (Business)getSqlSession().selectOne("com.runtime6.web.example.model.mapper.Home.getHome", param);
	}
}
