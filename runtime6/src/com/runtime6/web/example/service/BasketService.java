package com.runtime6.web.example.service;

import java.io.IOException;
import java.util.List;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.runtime6.web.example.model.dao.BasketDAO;
import com.runtime6.web.example.model.dto.Basket;
import com.runtime6.web.example.model.dto.BasketParam;

@Service
public class BasketService {
   @Autowired
   private BasketDAO basketDAO;
   
   public JSONObject getBasketList(BasketParam param) {
      JSONObject json = new JSONObject();
      List<Basket> basketList = null;
      basketList = basketDAO.getBasketList(param);
      System.out.println(param);
      System.out.println("basketList : " + basketList);
      json.accumulate("basketList", basketList);
      return json;
   }
   
   public Basket getBasket(BasketParam basket){
      return basketDAO.getBasket(basket);
   }
   @Transactional
   public int deleteBasket(BasketParam basketParam) {
      System.out.println("BasketService진입");
      int result = basketDAO.deleteBasket(basketParam);
      System.out.println("deleteBasket result : " + result);
      return result;
   }

   @Transactional
   public int insertPayment(BasketParam basketParam) throws IOException {
      System.out.println("BasketService 등록 집입");
      int result = 0;
      //바스켓파람만 []배열로 그리고 배열인데 반복적으로 들어가야하니까 반복
      for(int i=0; i<basketParam.getItem_name().length; i++) {
         Basket basket = new Basket();
         System.out.println(basketParam.getItem_f_no()[i]);
         basket.setItem_f_no(basketParam.getItem_f_no()[i]);
         basket.setCid(basketParam.getLoginUserId());
         basket.setVender_id(basketParam.getVender_id()[i]);
         basket.setItem_num(basketParam.getItem_num()[i]);
         basket.setItem_charge(basketParam.getItem_charge()[i]);
         basket.setTotal_charge(basketParam.getTotal_charge());
         basket.setItem_name(basketParam.getItem_name()[i]);
         basket.setC_no(basketParam.getC_no());
         result = basketDAO.insertPayment(basket);
      }
      System.out.println("result : " + result);

      return result;
   }
   @Transactional
	public int insertSuccessBasket(BasketParam basketParam) {
		System.out.println("BasketService insertSuccessBasket 진입");
		int result = basketDAO.insertSuccessBasket(basketParam);
		System.out.println("deleteBasket insertSuccessBasket result : " + result);
		return result;
	}  
	//나머지개수 업뎃
	public int updateRemainder(BasketParam param) {
		int result = 0;
		Basket basket=new Basket();
		 for(int i=0; i<param.getRemainder().length; i++) {
			 System.out.println("나머지개수: "+param.getRemainder()[i]);
			 System.out.println("아이템넘버: "+param.getItem_no()[i]);
			 basket.setRemainder(param.getRemainder()[i]);
			 basket.setItem_no(param.getItem_no()[i]);
			 result += basketDAO.updateRemainder(basket);
		 }		
		System.out.println("업뎃서비스");
		return result;
	}
	
}