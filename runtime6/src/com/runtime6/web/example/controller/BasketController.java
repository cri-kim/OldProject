package com.runtime6.web.example.controller;

import java.io.IOException;
import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextImpl;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.runtime6.web.common.mvc.model.vo.ResultVO;
import com.runtime6.web.example.model.dto.BasketParam;
import com.runtime6.web.example.model.dto.JoinParam;
import com.runtime6.web.example.service.BasketService;

@Controller
@RequestMapping("/basket")
public class BasketController {
	
	Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private BasketService basketService;

	@RequestMapping("/list")
	public String list(HttpServletRequest request) {
		logger.debug("basket/list 진입");
		HttpSession session = request.getSession();
		Enumeration<String> ans = session.getAttributeNames();
		SecurityContextImpl obj = (SecurityContextImpl) session.getAttribute("SPRING_SECURITY_CONTEXT");
		obj.getAuthentication().getPrincipal();
		return "basket/list";
	}

	@RequestMapping("/search")
	public @ResponseBody JSONObject search(BasketParam basketParam) {
		System.out.println("basketcontroller json 진입");
		JSONObject json = basketService.getBasketList(basketParam);
		System.out.println("jason : "+json);
		return json;
	}
	@RequestMapping(value="/list/{c_no}", method=RequestMethod.DELETE)
	public @ResponseBody ResultVO delete(BasketParam basketParam) {
		System.out.println("BasketController진입");	
		int result = basketService.deleteBasket(basketParam);
		System.out.println("basketcontroller result : " + result);
		ResultVO resultVO = new ResultVO();
		resultVO.put("delCnt",result);
		return resultVO;
	}

	@RequestMapping(value="/list", method = RequestMethod.POST)
	public ModelAndView insert(ModelAndView mav, @Valid BasketParam basketParam) throws IOException {
		System.out.println("BasketController 등록 진입");
		int result = basketService.insertPayment(basketParam);
		System.out.println("result : " + result);
		mav.addObject("crtCnt", result);
		mav.addObject("post", basketParam);
//		mav.setViewName("bbs/form");
		System.out.println("real success");
		System.out.println("mav : " + mav);
		return mav;
	}
	@RequestMapping(value="/list", method=RequestMethod.DELETE)
	public @ResponseBody ResultVO insertSuccessBasket(BasketParam basketParam) {
		System.out.println("BasketController insertSuccessBasket진입");	
		int result = basketService.insertSuccessBasket(basketParam);
		System.out.println("basketcontroller  insertSuccessBasket result : " + result);
		ResultVO resultVO = new ResultVO();
		resultVO.put("delCnt",result);
		return resultVO;
	}
	
	@RequestMapping(value="/updateRemainder", method=RequestMethod.PUT)
	public @ResponseBody ResultVO updateRemainder(@Valid BasketParam param, BindingResult bindingResult) {
		System.out.println(param.getRemainder().toString());
		int result = basketService.updateRemainder(param);
		System.out.println("result값은 "+result );
		ResultVO resultVO = new ResultVO();
		resultVO.put("updCnt",result);
		return resultVO;		
	}
	
}
