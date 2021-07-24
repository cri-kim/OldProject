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
import com.runtime6.web.example.model.dto.QnaPost;
import com.runtime6.web.example.model.dto.QnaPostParam;
import com.runtime6.web.example.service.QnaService;


@Controller
@RequestMapping("/qna")
public class QnaController {
	
	Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private QnaService qnaService;
	
	@RequestMapping("/reply")
	public String reply() {
		 return "qna/reply";
	}

	
	
	
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
		
		return "qna/list";
	}
	@RequestMapping("/search")
	public @ResponseBody JSONObject search(QnaPostParam postParam) {
		JSONObject json = qnaService.getPostList(postParam);
		System.out.println(json);
		return json;
	}
	
	@RequestMapping(value="/detail/{q_no}", method={RequestMethod.GET})
	public String detail(ModelMap mav, QnaPostParam postParam) {
		QnaPost post = qnaService.getPost(postParam);
		mav.addAttribute("post",post);
		return "qna/detail";
	}

	@RequestMapping(value="/detail/{q_no}", method=RequestMethod.DELETE)
	public @ResponseBody ResultVO delete(QnaPostParam postParam) {
		int result = qnaService.deletePost(postParam);
		ResultVO resultVO = new ResultVO();
		resultVO.put("delCnt",result);
		return resultVO;
	}
	
	@RequestMapping(value="/detail", method=RequestMethod.PUT)
	public @ResponseBody ResultVO update(@Valid  QnaPostParam postParam, BindingResult bindingResult) {
		System.out.println("QnaController update 들어옴");
		int result = qnaService.updatePost(postParam);
		ResultVO resultVO = new ResultVO();
		resultVO.put("updCnt",result);
		System.out.println("resultVO : "+resultVO);
		return resultVO;
	}
	
	
	@RequestMapping(value="/detail",method=RequestMethod.POST)
	public ModelAndView insert (ModelAndView mav, @Valid QnaPostParam postParam, BindingResult bindingResult) throws IOException {
		if (bindingResult.hasErrors()) {
			ResultVO rvo = new ResultVO();
			rvo.put("error", bindingResult.getFieldErrors());
			mav.addObject("err", rvo.toString());
		} else {
			int result = qnaService.insertPost(postParam);
			mav.addObject("crtCnt", result);	
		}
		
		mav.addObject("postParam", postParam);
		mav.setViewName("qna/form");
		return mav;
	}
	@RequestMapping(value="/detail/reply",method=RequestMethod.POST)
	public ModelAndView reply (ModelAndView mav, @Valid QnaPostParam postParam, BindingResult bindingResult) throws IOException {
		System.out.println("insert 들어움 ");

			int result = qnaService.replyPost(postParam);
			result+=qnaService.replyPostenabled(postParam);
			System.out.println(result);
			mav.addObject("crtCnt", result);	
			System.out.println("insert 들어움4444 ");

		System.out.println("insert 들어움4774445 ");
		
		mav.addObject("postParam", postParam);
		mav.setViewName("qna/list");
		return mav;
	}
	
	///성재오빠 부분 강사님 코드
	@RequestMapping("/form/{q_no}")
	public ModelAndView form(QnaPostParam postParam, ModelAndView mav){
		if (!"new".equals(postParam.getQ_no()))
		{
			QnaPost post = qnaService.getPost(postParam);
			mav.addObject("post", post);
		}
		mav.setViewName("qna/form");
		return mav;
	}
	

}