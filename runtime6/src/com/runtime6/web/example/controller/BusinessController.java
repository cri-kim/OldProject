package com.runtime6.web.example.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextImpl;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.runtime6.web.common.mvc.model.vo.ResultVO;
import com.runtime6.web.example.model.dto.Business;
import com.runtime6.web.example.model.dto.BusinessParam;
import com.runtime6.web.example.model.dto.Basket;
import com.runtime6.web.example.model.dto.Join;
import com.runtime6.web.example.model.dto.JoinParam;
import com.runtime6.web.example.service.BusinessService;
import com.runtime6.web.example.service.FileService;
import com.runtime6.web.example.service.MypageService;

@Controller
@RequestMapping("/business")
public class BusinessController {
	
	@Autowired
	private BusinessService businessService;
	@Autowired
	private MypageService mypageService;
	@Autowired
	private FileService fileService;
	
	@RequestMapping("/itemlist")
	public String itemlist(HttpServletRequest request) {		
		HttpSession session = request.getSession();	
		//Enumeration<String> ans = session.getAttributeNames();
		SecurityContextImpl obj = (SecurityContextImpl)session.getAttribute("SPRING_SECURITY_CONTEXT");
		obj.getAuthentication().getPrincipal();	
		return "business/itemlist";
	}
	
	@RequestMapping("/search")
	public @ResponseBody JSONObject search(BusinessParam param) {
		JSONObject json = businessService.getBusinessList(param);
		return json;
	}

	@RequestMapping(value="/itemdetail/{item_no}", method={RequestMethod.GET})
	public String itemdetail(JoinParam joinparam, ModelMap mav, BusinessParam param) {
		Business business = businessService.getBusiness(param);
		mav.addAttribute("business",business);
		return "business/itemdetail";
	}

		@RequestMapping(value="/itemlist/{cid}", method={RequestMethod.GET})
		public String myinfor(ModelMap mav,  JoinParam param) {
			Join join=mypageService.getMyinfor(param);
			mav.addAttribute("join",join);
			return "business/itemlist";
		}

	@RequestMapping("/itemform/{item_no}")
	public ModelAndView itemform(BusinessParam param, ModelAndView mav){
		if(!"insert".equals(param.getItem_no())){		
			Business business = businessService.getBusiness(param);
			mav.addObject("business",business);
		}
		mav.setViewName("/business/itemform");
		return mav;
	}
	
	@RequestMapping(value="/itemdetail", method=RequestMethod.POST)
	public ModelAndView insert(ModelAndView mav, @Valid BusinessParam param, BindingResult bindingResult) throws IOException {	
		if(bindingResult.hasErrors()){
			ResultVO rvo = new ResultVO();
			rvo.put("error", bindingResult.getFieldErrors());
			mav.addObject("err",rvo.toString());
			System.out.println("rvo : " + rvo.toString());
		}else {
			System.out.println("서비스전 컨트롤러");
			int result = businessService.insertBusiness(param);
			System.out.println("result : " + result);
			mav.addObject("crtCnt",result);
		}
		System.out.println("aaaaaaaaaaa");
		mav.addObject("businessParam",param);
		mav.setViewName("business/itemform");
		System.out.println("real success");
		System.out.println("mav : "+mav);
		return mav;
	}
	
	
	@RequestMapping(value="/insertBasket", method=RequestMethod.POST)//http 전송 방식은 포스트 방식
	public @ResponseBody
	ResultVO insertBasket(@Valid Basket basket, BindingResult bindingResult) {
		ResultVO result = null;
		System.out.println("컨트롤러");
		if (bindingResult.hasErrors()) {
			result = new ResultVO();
			result.put("error", bindingResult.getAllErrors());
		} else {
			System.out.println("정상값");
			result = businessService.insertBasket(basket); // json으로 결과를 돌려주겠구나
			System.out.println("aaaaaaaaaaa "+result);
		}
		return result;
	}
	
	
	//상단 전체검색
	@RequestMapping("/totalsearch={searchCondition}={searchText}")
	public String totalsearch(HttpServletRequest request) {		
		return "business/totalsearch";
	}
	
	@RequestMapping("/search1/{searchCondition}/{searchText}")
	public @ResponseBody JSONObject search1(BusinessParam param) {
		System.out.println("상단검색컨트롤러시작");
		System.out.println(param.getSearchCondition());
		System.out.println(param.getSearchText());
		JSONObject json = businessService.getTotalSearch(param);
		return json;
	}
	
	
}
