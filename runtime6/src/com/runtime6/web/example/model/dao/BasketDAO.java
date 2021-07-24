package com.runtime6.web.example.model.dao;

import java.util.List;

import com.runtime6.web.example.model.dto.Basket;
import com.runtime6.web.example.model.dto.BasketParam;


public interface BasketDAO {
	
	public List<Basket> getBasketList(BasketParam param);

	public Basket getBasket(BasketParam param);
	
	public int deleteBasket(BasketParam param);
	
	public int insertPayment(Basket post);

	public int insertSuccessBasket(BasketParam param);
	
	public int updateRemainder(Basket basket);//나머지개수 업뎃

}
