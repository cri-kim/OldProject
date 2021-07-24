package com.runtime6.web.example.model.dao;

import java.util.List;

import com.runtime6.web.example.model.dto.Business;
import com.runtime6.web.example.model.dto.BusinessParam;
import com.runtime6.web.example.model.dto.Basket;

public interface BusinessDAO {
	public List<Business> getBusinessList(BusinessParam param);

	public Business getBusinessFile(String item_f_no);
	
	public int getCountBusinessList(BusinessParam param);
		
	public int getCountSearchList(BusinessParam param);
	
	public Business getBusiness(BusinessParam param);
	
	public int insertBusiness(Business business);

	public int insertBusinessFile(Business business);
	
	public int insertBasket(Basket basket);

	
	
	public int insertUploadFile(Business business);
	
	public Business getUploadFile(String item_f_no);

}
