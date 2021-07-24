package com.runtime6.web.example.model.dao.impl;



import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.stereotype.Repository;

import com.runtime6.web.common.constant.VSConstants;
import com.runtime6.web.example.model.dao.JoinDao;
import com.runtime6.web.example.model.dto.Join;
import com.runtime6.web.example.model.dto.JoinParam;
import com.runtime6.web.example.model.dto.Post;

//Repository 잇어야 스프링에서 DAO라고 인식하게 한다. mybatis는 이런식으로 (아래)로 쓴다
@Repository
public class JoinDaoImpl extends SqlSessionDaoSupport implements JoinDao{

	@Override
	public int createUser(JoinParam param) {
		return getSqlSession().insert("com.runtime6.web.example.model.mapper.Join.createUser",param);
	}
	
	@Override
	public int createProvider(JoinParam param) {
		return getSqlSession().insert("com.runtime6.web.example.model.mapper.Join.createProvider",param);
	}
	
	@Override
	public int createBussFile(Join join) {
		return getSqlSession().insert("com.runtime6.web.example.model.mapper.Join.createBussFile",join);
	}

	
	@Override
	public int checkCid(JoinParam param) {
		return  (Integer)getSqlSession().selectOne(
				"com.runtime6.web.example.model.mapper.Join.checkCid",
				param);
	}	

	
	@Override
	public int createUserAuthority(JoinParam param) {
		param.setRole(VSConstants.AUTH_ROLE_USER);
		return getSqlSession().insert(
				"com.runtime6.web.example.model.mapper.Join.createUserAuthority"
				,param);
		
	}


}