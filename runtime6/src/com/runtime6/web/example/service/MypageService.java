package com.runtime6.web.example.service;


import java.util.List;

import net.sf.json.JSONObject;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.runtime6.web.example.model.dao.MypageDAO;
import com.runtime6.web.example.model.dto.Join;
import com.runtime6.web.example.model.dto.JoinParam;
import com.runtime6.web.example.model.dto.Paging;



@Service
public class MypageService {
	@Autowired
	private MypageDAO mypageDAO;
	//회원리스트
	public JSONObject getMypageUserList(JoinParam param) {
		JSONObject json = new JSONObject();
		List<Join> joinList=null;
		
		int count= mypageDAO.getCountMypageUserList(param);
		Paging paging = new Paging(param.getCurrPageNo(), count);
		param.setFromRowNum(paging.getFromRowNum());
		param.setToRowNum(paging.getToRowNum());
	
		if(count>0){
			joinList=mypageDAO.getMypageUserList(param);  
		}
		json.accumulate("paging", paging);      	
		json.accumulate("joinList", joinList);
		return json;
	}	
	//강제탈퇴 enabled값을 변경
	public int stopForcedUser(JoinParam param) {
		return mypageDAO.stopForcedUser(param);
	}

	
		
	public Join getMyinfor(JoinParam param){
		return mypageDAO.getMyinfor(param);
	}
	public int updateUserinfor(JoinParam param) {
		return mypageDAO.updateUserinfor(param);
	}
	
	public int updateProviderinfor(JoinParam param) {
		System.out.println("서비스");
		return mypageDAO.updateProviderinfor(param);
	}
	//개인탈퇴
	public int stopUser(JoinParam param) {
		return mypageDAO.stopUser(param);
	}
	
	//구매리스트
	public JSONObject getBuyList(JoinParam param) {
		JSONObject json = new JSONObject();
		List<Join> joinList=null;		
		int count= mypageDAO.getCountBuyList(param);
		System.out.println("count  "+count);
		Paging paging = new Paging(param.getCurrPageNo(), count);
		param.setFromRowNum(paging.getFromRowNum());
		param.setToRowNum(paging.getToRowNum());
		System.out.println("구매서비스");
		if(count>0){
			joinList=mypageDAO.getBuyList(param);  
		}
		json.accumulate("paging", paging);      	
		json.accumulate("buyList", joinList);
		return json;
	}	
	
	//판매리스트
		public JSONObject getSellList(JoinParam param) {
			JSONObject json = new JSONObject();
			List<Join> joinList=null;		
			int count= mypageDAO.getCountSellList(param);
			System.out.println("count  "+count);
			Paging paging = new Paging(param.getCurrPageNo(), count);
			param.setFromRowNum(paging.getFromRowNum());
			param.setToRowNum(paging.getToRowNum());
			System.out.println("판매서비스");
			if(count>0){
				joinList=mypageDAO.getSellList(param);
			}
			json.accumulate("paging", paging);      	
			json.accumulate("sellList", joinList);
			return json;
		}	
}
