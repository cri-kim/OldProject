package com.runtime6.web.example.controller;

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

import com.runtime6.web.common.mvc.model.vo.ResultVO;
import com.runtime6.web.example.model.dto.Join;
import com.runtime6.web.example.model.dto.JoinParam;
import com.runtime6.web.example.service.MypageService;


@Controller
@RequestMapping("/mypage")
public class MypageController {	
	Logger logger = Logger.getLogger(this.getClass());
	@Autowired
	private MypageService mypageService;
	
	@RequestMapping(value="/infor")
	public String infor(HttpServletRequest request) {
		HttpSession session = request.getSession();
		//키값을 찾아야하니까 
		//유저 정보 얻기 방법2
		Enumeration<String> ans = session.getAttributeNames();
		SecurityContextImpl obj = (SecurityContextImpl)session.getAttribute("SPRING_SECURITY_CONTEXT");
		obj.getAuthentication().getPrincipal();	
		return "mypage/infor";
	}
	
	//회원전체리스트
	@RequestMapping("/search")
	public @ResponseBody JSONObject search(JoinParam param) {
		JSONObject json = mypageService.getMypageUserList(param);
		return json;
	}
	//강제탈퇴
		@RequestMapping(value="/forcedUser", method=RequestMethod.PUT)
		public @ResponseBody ResultVO stopForcedUser(@Valid JoinParam param, BindingResult bindingResult) {
			int result = mypageService.stopForcedUser(param);
			ResultVO resultVO = new ResultVO();
			resultVO.put("updCnt",result);
			return resultVO;
			
		}
		

	/*@RequestMapping("/myinfor")
		public String myinfor() {
			 return "mypage/myinfor";
		}*/
		
	//개인정보
	@RequestMapping(value="/myinfor/{cid}", method={RequestMethod.GET})
	public String myinfor(ModelMap mav,  JoinParam param) {
		Join join=mypageService.getMyinfor(param);
		mav.addAttribute("join",join);
		return "mypage/myinfor";
	}
	
	@RequestMapping(value="/updUser", method=RequestMethod.PUT)
	public @ResponseBody ResultVO updUser(@Valid JoinParam param, BindingResult bindingResult) {
		int result = mypageService.updateUserinfor(param);
		ResultVO resultVO = new ResultVO();
		resultVO.put("updCnt",result);
		return resultVO;	
	}
	
	@RequestMapping(value="/updProvider", method=RequestMethod.PUT)
	public @ResponseBody ResultVO updProvider(@Valid JoinParam param, BindingResult bindingResult) {
		System.out.println("zzzzzzzzzzzzzzzzzz");
		int result = mypageService.updateProviderinfor(param);
		System.out.println(result);
		ResultVO resultVO = new ResultVO();
		resultVO.put("updCnt",result);
		return resultVO;	
	}
	//자의탈퇴
	@RequestMapping(value="/stopUser", method=RequestMethod.PUT)
	public @ResponseBody ResultVO stopUser(@Valid JoinParam param, BindingResult bindingResult) {
		int result = mypageService.stopUser(param);
		ResultVO resultVO = new ResultVO();
		resultVO.put("updCnt",result);
		return resultVO;		
	}
	
	
	
	//구매리스트
	@RequestMapping(value="/buyinfor/{cid}", method={RequestMethod.GET})
	public String buyinfor(ModelMap mav,  JoinParam param) {	
		return "mypage/buyinfor";
	}
	@RequestMapping("/buylist")
	public @ResponseBody JSONObject buylist(JoinParam param) {
		JSONObject json = mypageService.getBuyList(param);
		return json;
	}
	//판매리스트
	@RequestMapping(value="/sellinfor/{cid}", method={RequestMethod.GET})
	public String sellinfor(ModelMap mav,  JoinParam param) {	
		return "mypage/sellinfor";
	}
	@RequestMapping("/selllist")
	public @ResponseBody JSONObject selllist(JoinParam param) {
		JSONObject json = mypageService.getSellList(param);
		return json;
	}

}
