package com.runtime6.web.example.model.dao.impl;

import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.stereotype.Repository;

import com.runtime6.web.example.model.dao.BusinessDAO;
import com.runtime6.web.example.model.dto.Business;
import com.runtime6.web.example.model.dto.BusinessParam;
import com.runtime6.web.example.model.dto.Basket;

@Repository
public class BusinessDAOImpl extends SqlSessionDaoSupport implements BusinessDAO {

	@SuppressWarnings("unchecked")
	public List<Business> getBusinessList(BusinessParam param) {
		return getSqlSession().selectList("com.runtime6.web.example.model.mapper.Business.getBusinessList",param);
	}

	@Override
	public int getCountBusinessList(BusinessParam param) {
		return (Integer)getSqlSession().selectOne(
				"com.runtime6.web.example.model.mapper.Business.getCountBusinessList", param);
	}
	//검색한값에 페이징을 위한 카운트
	@Override
	public int getCountSearchList(BusinessParam param) {
		return (Integer)getSqlSession().selectOne(
				"com.runtime6.web.example.model.mapper.Business.getCountSearchList", param);
	}

	@Override
	public Business getBusiness(BusinessParam param) {
		return (Business)getSqlSession().selectOne("com.runtime6.web.example.model.mapper.Business.getBusiness", param);
	}

	@Override
	public Business getBusinessFile(String item_f_no) {
		return (Business)getSqlSession().selectOne("com.runtime6.web.example.model.mapper.Business.getBusinessFile", item_f_no);
	}
	
	@Override
	public int insertBusiness(Business business) {
		return getSqlSession().insert("com.runtime6.web.example.model.mapper.Business.insertBusiness",business);

	}
	@Override
	public int insertBusinessFile(Business business) {
		return getSqlSession().insert("com.runtime6.web.example.model.mapper.Business.insertBusinessFile",business);
	}

	@Override
	public int insertBasket(Basket basket) {
		return getSqlSession().insert("com.runtime6.web.example.model.mapper.Business.insertBasket",basket);
	}
	
	@Override
	public int insertUploadFile(Business business) {
		return getSqlSession().insert("com.runtime6.web.example.model.mapper.Business.insertUploadFile",business);
	}

	@Override
	public Business getUploadFile(String item_f_no) {
		return (Business)getSqlSession().selectOne("com.runtime6.web.example.model.mapper.Business.getUploadFile", item_f_no);
	}




}
