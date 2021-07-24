package com.runtime6.web.example.controller;

import java.io.IOException;

import javax.validation.Valid;

import net.sf.json.JSONObject;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.runtime6.web.common.mvc.model.vo.ResultVO;
import com.runtime6.web.example.model.dto.JoinParam;
import com.runtime6.web.example.model.dto.PostParam;
import com.runtime6.web.example.service.JoinService;
//import com.runtime6.web.example.service.MfmCompanyService;

//@이렇게 해줘야 컨트롤러라는 거 아니면 xml에서 선언
@Controller
//만약 /join 대신 login이라면 login인 url에 들어간다
@RequestMapping("/join")
public class JoinController {
	
	@SuppressWarnings("unused")
	private Logger logger = Logger.getLogger(JoinController.class);
	
	@Autowired//private임에도 불구하고 컨트롤러가 생성되고 호출이 되면 서비스에 객체에 맵핑을 한다.
	private JoinService joinService;

	//join 다음에 index다라는 뜻이며 있으면 이밑에껄 수행한다. 겟방식으로 들어온다. 포스트나 다른거면 안들어온다. 
	//어노테이션으로 하는 것
	@RequestMapping(value="/index", method=RequestMethod.GET)
	public String join() {//파라미터로 모델이라는거 받는데 받아도 되고 안받아도 된다.
		return "join";//리절버에 의해서 어플리케이션 컨텍스트 에스씨엠에 
	}
	
	@RequestMapping(value="/createUser", method=RequestMethod.POST)//http 전송 방식은 포스트 방식
	public @ResponseBody
	ResultVO createUser(@Valid JoinParam join, BindingResult bindingResult) {
		ResultVO result = null;
		if (bindingResult.hasErrors()) {
			result = new ResultVO();
			result.put("error", bindingResult.getAllErrors());
		} else {
			result = joinService.createUser(join); // json으로 결과를 돌려주겠구나
		}
		return result;
	}
	
	
	
	@RequestMapping(value="/createProvider", method=RequestMethod.POST)
	public ModelAndView createProvider(ModelAndView mav, @Valid  JoinParam param, BindingResult bindingResult) throws IOException {
		if(bindingResult.hasErrors()){
			ResultVO rvo = new ResultVO();
			rvo.put("error", bindingResult.getFieldErrors());
			mav.addObject("err",rvo.toString());
			System.out.println("rvo : " + rvo.toString());
		}else {
			System.out.println("진입");
			int result = joinService.createProvider(param);
			System.out.println("result : " + result);
			mav.addObject("crtCnt",result);
		}
		
		mav.addObject("joinParam",param);
		mav.setViewName("join");
		System.out.println("mav : "+mav);
		return mav;
	}

	
	@RequestMapping(value="/checkValidation", method=RequestMethod.GET)
	public @ResponseBody ResultVO checkValidation(JoinParam param) {
		ResultVO result = joinService.checkValidation(param);
		return result;

	}

}
