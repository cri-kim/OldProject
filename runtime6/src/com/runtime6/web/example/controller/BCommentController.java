package com.runtime6.web.example.controller;

import javax.validation.Valid;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.runtime6.web.common.mvc.model.vo.ResultVO;
import com.runtime6.web.example.model.dto.BCommentParam;
import com.runtime6.web.example.service.BCommentService;


@Controller
@RequestMapping("/bcmt")
public class BCommentController {
	Logger logger = Logger.getLogger(getClass());
	@Autowired
	private BCommentService bcommentService;
	
	//조회 기능 /cmt/comment/{bbsNum} , GET 메소드
	@RequestMapping(value="/bcomment/{item_no}",method=RequestMethod.GET)
	public @ResponseBody ResultVO list(BCommentParam param) {
		return bcommentService.getBCommentList(param);
	}
	
	//삭제 기능 /comment/{cmt_Num} , DELETE 메소드
	@RequestMapping(value="/bcomment/{cmt_num}",method=RequestMethod.DELETE)
	public @ResponseBody ResultVO delete(@PathVariable String cmt_num) {
		return bcommentService.deleteBComment(cmt_num);
	}
	
	//수정 기능 /comment , POST 메소드
	@RequestMapping(value="/bcomment",method=RequestMethod.PUT)
	public @ResponseBody ResultVO update(@Valid BCommentParam param, 
			BindingResult bindingResult) {
		System.out.println("수정되라라라라라");
		if(bindingResult.hasErrors()){
			System.out.println("에러");
			ResultVO resultVO = new ResultVO();
			resultVO.put("error",bindingResult.getFieldErrors());
			return resultVO;
		} else {
			System.out.println("수정됨");
			return bcommentService.updateBComment(param);
		}
	}
	
	
	//등록 기능 /comment , PUT 메소드
	@RequestMapping(value="/bcomment",method=RequestMethod.POST)
	public @ResponseBody ResultVO insert(@Valid BCommentParam param,
			BindingResult bindingResult) {
		System.out.println("드루와");
		if(bindingResult.hasErrors()){
			System.out.println("에러에러옹ㄱ");
			ResultVO resultVO = new ResultVO();
			resultVO.put("error",bindingResult.getFieldErrors());
			return resultVO;
		} else{
			System.out.println("성공");
			ResultVO resultVO = bcommentService.insertBComment(param);
			System.out.println(resultVO);
//			logger.debug(resultVO.get("crt_Cnt"));
//			if((resultVO).get("crt_Cnt").equals(1)) {
//				logger.debug("조회전");
//				Object commentList = commentService.getCommentList(commentparam).get("commentList");
//				resultVO.put("commentList",commentList);
//				logger.debug(commentList);
//			}
			return resultVO;
		}
	}
}
