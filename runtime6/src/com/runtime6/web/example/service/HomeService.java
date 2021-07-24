package com.runtime6.web.example.service;

import java.util.List;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.runtime6.web.example.model.dao.HomeDAO;
import com.runtime6.web.example.model.dto.Business;
import com.runtime6.web.example.model.dto.BusinessParam;

@Service
public class HomeService {
	@Autowired
	   private HomeDAO homeDAO;
	   
	   public JSONObject getHomeList(BusinessParam param) {
		   System.out.println("homeservice 진입1");
	      JSONObject json = new JSONObject();
	      List<Business> homeList = null;
	      homeList = homeDAO.getHomeList(param);
	      json.accumulate("homeList", homeList);
			System.out.println("json result : " + json);
	      return json;
	   }
	   public JSONObject getHomeList2(BusinessParam param) {
		   System.out.println("homeservice2 진입1");
	      JSONObject json = new JSONObject();
	      List<Business> homeList2 = null;
	      homeList2 = homeDAO.getHomeList2(param);
	      json.accumulate("homeList2", homeList2);
			System.out.println("json result : " + json);
	      return json;
	   }
	   public Business getHome(BusinessParam param){
			System.out.println("homeservice 진입2");
	      return homeDAO.getHome(param);
	   }
}
