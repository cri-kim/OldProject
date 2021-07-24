package com.runtime6.web.example.controller;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.runtime6.web.example.model.dto.BusinessParam;
import com.runtime6.web.example.service.HomeService;

@Controller
public class HomeController {

	@Autowired
	private HomeService homeService;

	@RequestMapping("/home")
	public String list() {
		System.out.println("/home controller진입1");
		return "home";
	}

	@RequestMapping("/home/search")
	public @ResponseBody
	JSONObject search(BusinessParam param) {
		System.out.println("/home/search controller진입2");
		JSONObject json = homeService.getHomeList(param);
		return json;
	}
	@RequestMapping("/home/search2")
	public @ResponseBody
	JSONObject search2(BusinessParam param) {
		System.out.println("/home/search2 controller2진입2");
		JSONObject json = homeService.getHomeList2(param);
		return json;
	}

}
