package com.runtime6.web.example.model.dao;

import java.util.List;

import com.runtime6.web.example.model.dto.Business;
import com.runtime6.web.example.model.dto.BusinessParam;

public interface HomeDAO {
	
	public List<Business> getHomeList(BusinessParam param);
	
	public List<Business> getHomeList2(BusinessParam param);
	
	public Business getHome(BusinessParam param);
}
