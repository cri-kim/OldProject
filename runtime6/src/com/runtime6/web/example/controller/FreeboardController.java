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
import com.runtime6.web.example.model.dto.FB_Post;
import com.runtime6.web.example.model.dto.FB_PostParam;
import com.runtime6.web.example.model.dto.PostParam;
import com.runtime6.web.example.service.FreeboardService;


@Controller
@RequestMapping("/freeboard")
public class FreeboardController {
	
	Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private FreeboardService freeboardService;
	
	@RequestMapping("/contact")
	public String contact(HttpServletRequest request) {
		HttpSession session = request.getSession();
		Enumeration<String> ans = session.getAttributeNames();
		SecurityContextImpl obj = (SecurityContextImpl)session.getAttribute("SPRING_SECURITY_CONTEXT");
		obj.getAuthentication().getPrincipal();
		
		return "freeboard/contact";
	}
	@RequestMapping("/search")
	public @ResponseBody JSONObject search(FB_PostParam postParam) {
		JSONObject json = freeboardService.getPostList(postParam);
		System.out.println(json);
		return json;
	}
	
	@RequestMapping(value="/detail/{fb_id}", method={RequestMethod.GET})
	public String detail(ModelMap mav, FB_PostParam postParam) {
		FB_Post post = freeboardService.getPost(postParam);
		mav.addAttribute("post",post);
		return "freeboard/detail";
	}

	@RequestMapping(value="/detail/{fb_id}", method=RequestMethod.DELETE)
	public @ResponseBody ResultVO delete(FB_PostParam postParam) {
		int result = freeboardService.deletePost(postParam);
		ResultVO resultVO = new ResultVO();
		resultVO.put("delCnt",result);
		return resultVO;
	}
	
	@RequestMapping(value="/detail/update", method=RequestMethod.PUT)
	public @ResponseBody ResultVO update(@Valid  FB_PostParam postParam,BindingResult bindingResult) {
		int result = freeboardService.updatePost(postParam);
		ResultVO resultVO = new ResultVO();
		resultVO.put("updCnt",result);
		return resultVO;
	}


	@RequestMapping(value="/detail",method=RequestMethod.POST)
	public ModelAndView insert (ModelAndView mav, @Valid FB_PostParam postParam, BindingResult bindingResult) throws IOException {
		if (bindingResult.hasErrors()) {
			ResultVO rvo = new ResultVO();
			rvo.put("error", bindingResult.getFieldErrors());
			mav.addObject("err", rvo.toString());
		} else {
			int result = freeboardService.insertPost(postParam);
			mav.addObject("crtCnt", result);	
		}
		
		mav.addObject("postParam", postParam);
		mav.setViewName("freeboard/form");
		return mav;
	}
	///성재오빠 부분 강사님 코드
	@RequestMapping("/form/{fb_id}")
	public ModelAndView form(FB_PostParam postParam, ModelAndView mav){
		if (!"new".equals(postParam.getFb_id()))
		{
			FB_Post post = freeboardService.getPost(postParam);
			mav.addObject("post", post);
		}
		mav.setViewName("freeboard/form");
		return mav;
	}
	
}