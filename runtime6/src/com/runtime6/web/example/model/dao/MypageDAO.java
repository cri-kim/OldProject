package com.runtime6.web.example.model.dao;

import java.util.List;

import com.runtime6.web.example.model.dto.Join;
import com.runtime6.web.example.model.dto.JoinParam;
import com.runtime6.web.example.model.dto.Post;
import com.runtime6.web.example.model.dto.PostParam;

public interface MypageDAO {

	public List<Join> getMypageUserList(JoinParam param);//전체회원리스트(관리자)
	
	public int getCountMypageUserList(JoinParam param);//전체회원리스트 카운트(페이징) 

	public int stopForcedUser(JoinParam param);//강제회원탈퇴

	

	public Join getMyinfor(JoinParam param);//개인정보조회
	
	public int updateUserinfor(JoinParam param);//사용자 정보수정
	
	public int updateProviderinfor(JoinParam param);//사업자 정보수정
	
	public int stopUser(JoinParam param);//회원탈퇴
	
	
	
	public List<Join> getBuyList(JoinParam param);//사용자구매리스트
	
	public int getCountBuyList(JoinParam param);//사용자 구매리스트 카운트
	
	public List<Join> getSellList(JoinParam param);//사업자판매리스트
	
	public int getCountSellList(JoinParam param);//사업자 판매리스트 카운트
}
