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
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.runtime6.web.common.mvc.model.vo.ResultVO;
import com.runtime6.web.example.model.dto.Post;
import com.runtime6.web.example.model.dto.PostParam;
import com.runtime6.web.example.service.BbsService;


@Controller
@RequestMapping("/bbs")
public class BbsController {
	
	Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private BbsService bbsService;
	
	@RequestMapping("/list")
	public String list(HttpServletRequest request) {
		logger.debug("kikikiki");
		logger.error("erererere");
		//request에 요청해서 세션을 얻는다.
		HttpSession session = request.getSession();
		//키값을 찾아야하니까 
		//유저 정보 얻기 방법2
		Enumeration<String> ans = session.getAttributeNames();
		SecurityContextImpl obj = (SecurityContextImpl)session.getAttribute("SPRING_SECURITY_CONTEXT");
		obj.getAuthentication().getPrincipal();
		
		return "bbs/list";
	}
	@RequestMapping("/search")
	public @ResponseBody JSONObject search(PostParam postParam) {
		JSONObject json = bbsService.getPostList(postParam);
		System.out.println(json);
		return json;
	}
	
	@RequestMapping(value="/detail/{b_id}", method={RequestMethod.GET})
	public String detail(ModelMap mav, PostParam postParam) {
		Post post = bbsService.getPost(postParam);
		mav.addAttribute("post",post);
		return "bbs/detail";
	}

	@RequestMapping(value="/detail/{b_id}", method=RequestMethod.DELETE)
	public @ResponseBody ResultVO delete(PostParam postParam) {
		int result = bbsService.deletePost(postParam);
		ResultVO resultVO = new ResultVO();
		resultVO.put("delCnt",result);
		return resultVO;
	}
	
	@RequestMapping(value="/detail", method=RequestMethod.PUT)
	public @ResponseBody ResultVO update(@Valid  PostParam postParam, BindingResult bindingResult) {
		int result = bbsService.updatePost(postParam);
		ResultVO resultVO = new ResultVO();
		resultVO.put("updCnt",result);
		return resultVO;
	}
	
	@RequestMapping("/form/{b_id}")
	public ModelAndView form(PostParam postParam, ModelAndView mav){
		if(!"new".equals(postParam.getB_id())){
			
			Post post = bbsService.getPost(postParam);
			mav.addObject("post",post);
		}
		mav.setViewName("/bbs/form");
		return mav;
	}

	@RequestMapping(value="/detail", method=RequestMethod.POST)
	public ModelAndView insert(ModelAndView mav, @Valid  PostParam postParam, BindingResult bindingResult) throws IOException {
		logger.error("zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz");
	/*	if(bindingResult.hasErrors()){
			ResultVO rvo = new ResultVO();
			rvo.put("error", bindingResult.getFieldErrors());
			mav.addObject("err",rvo.toString());
			System.out.println("rvo : " + rvo.toString());
		}else {*/
			System.out.println("진입");
			int result = bbsService.insertPost(postParam);
			System.out.println("result : " + result);
			mav.addObject("crtCnt",result);
		//}
		System.out.println("aaaaaaaaaaa");
		mav.addObject("postParam",postParam);
		mav.setViewName("bbs/form");
		System.out.println("real success");
		System.out.println("mav : "+mav);
		return mav;
	}
	
}