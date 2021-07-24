package com.runtime6.web.example.model.dao;


import com.runtime6.web.example.model.dto.Join;
import com.runtime6.web.example.model.dto.JoinParam;
import com.runtime6.web.example.model.dto.Post;


public interface JoinDao {
	
	public int createUser(JoinParam param);
	
	public int checkCid(JoinParam param);
	
	public int createUserAuthority(JoinParam param);

	public int createProvider(JoinParam param);
		
	public int createBussFile(Join join);

}
