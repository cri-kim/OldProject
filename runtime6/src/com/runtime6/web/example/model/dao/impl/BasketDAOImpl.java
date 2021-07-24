package com.runtime6.web.example.model.dao.impl;

import java.util.List;

import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.stereotype.Repository;

import com.runtime6.web.example.model.dao.BasketDAO;
import com.runtime6.web.example.model.dto.Basket;
import com.runtime6.web.example.model.dto.BasketParam;
import com.runtime6.web.example.model.dto.JoinParam;

@Repository
public class BasketDAOImpl extends SqlSessionDaoSupport implements BasketDAO {

	@SuppressWarnings("unchecked")
	public List<Basket> getBasketList(BasketParam param) {
		return getSqlSession()
				.selectList("com.runtime6.web.example.model.mapper.Basket.getBasketList"
				,param);
	}

	public Basket getBasket(BasketParam param) {
		return (Basket)getSqlSession().selectOne(
				"com.runtime6.web.example.model.mapper.Basket.getBasket", param);
	}
	@Override
	public int deleteBasket(BasketParam param) {
		System.out.println("BasketDAOImpl 진입");
		return getSqlSession().delete("com.runtime6.web.example.model.mapper.Basket.deleteBasket",param);
	}
	@Override
	public int insertPayment(Basket param) {
		System.out.println("BasketDAOImpl 등록 진입");
		return getSqlSession().insert("com.runtime6.web.example.model.mapper.Basket.insertPayment",param);
	}
	@Override
	public int insertSuccessBasket(BasketParam param) {
		System.out.println("BasketDAOImpl 진입");
		return getSqlSession().delete("com.runtime6.web.example.model.mapper.Basket.insertSuccessBasket",param);
	}

	@Override
	public int updateRemainder(Basket basket) {
		return getSqlSession().update(
				"com.runtime6.web.example.model.mapper.Basket.updateRemainder",basket);
	}

	
}
