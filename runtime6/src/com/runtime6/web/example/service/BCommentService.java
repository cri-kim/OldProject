package com.runtime6.web.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.runtime6.web.common.mvc.model.vo.ResultVO;
import com.runtime6.web.example.model.dao.BCommentDAO;
import com.runtime6.web.example.model.dto.BComment;
import com.runtime6.web.example.model.dto.BCommentParam;


@Service
public class BCommentService {
	@Autowired
	private BCommentDAO bcommentDAO;
	
	public ResultVO getBCommentList(BCommentParam param) {
		List<BComment> list = bcommentDAO.getBCommentList(param);
		ResultVO result = new ResultVO();
		result.put("commentList", list);
		return result;
	}
	
	public ResultVO deleteBComment(String cmt_Num){
		int cnt = bcommentDAO.deleteBComment(cmt_Num);
		ResultVO result = new ResultVO();
		result.put("delCnt", cnt);
		return result;
	}

	public ResultVO updateBComment(BCommentParam param){
		BComment bcomment = new BComment();
		bcomment.setUpd_cid(param.getUpdId());
		bcomment.setCmt_num(param.getCmt_num());
		bcomment.setComments(param.getComment());
		int cnt = bcommentDAO.updateBComment(bcomment);
		ResultVO result = new ResultVO();
		result.put("updCnt", cnt);
		return result;
	}
	public ResultVO insertBComment(BCommentParam param){
		BComment bcomment = new BComment();
		System.out.println("111");
		bcomment.setCid(param.getLoginUserId());
		bcomment.setCrt_cid(param.getCrtId());
		bcomment.setItem_no(param.getItem_no());
		bcomment.setComments(param.getComment());
		System.out.println(bcomment.getCid());
		System.out.println(bcomment.getCrt_cid());
		System.out.println(bcomment.getItem_no());
		System.out.println(bcomment.getComments());
		int cnt = bcommentDAO.insertBComment(bcomment);
		System.out.println(cnt);
		ResultVO result = new ResultVO();
		result.put("crtCnt", cnt);
		System.out.println("result : "+result);
		return result;
	}
}
