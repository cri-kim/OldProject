package com.runtime6.web.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.runtime6.web.common.mvc.model.vo.ResultVO;
import com.runtime6.web.example.model.dao.CommentDAO;
import com.runtime6.web.example.model.dto.Comment;
import com.runtime6.web.example.model.dto.CommentParam;

@Service
public class CommentService {
	
	@Autowired
	private CommentDAO commentDAO;
	
	public ResultVO getCommentList(CommentParam commentParam) {
		List<Comment> list = commentDAO.getCommentList(commentParam);
		ResultVO result = new ResultVO();
		result.put("commentList", list);
		return result;
	}
	
	public ResultVO deleteComment(String cmt_Num){
		int cnt = commentDAO.deleteComment(cmt_Num);
		ResultVO result = new ResultVO();
		result.put("delCnt", cnt);
		return result;
	}

	public ResultVO updateComment(CommentParam commentParam){
		Comment comment = new Comment();
		comment.setUpd_Cid(commentParam.getUpdId());
		comment.setCmt_Num(commentParam.getCmt_Num());
		comment.setComments(commentParam.getComment());
		int cnt =  commentDAO.updateComment(comment);
		ResultVO result = new ResultVO();
		result.put("updCnt", cnt);
		return result;
	}
	public ResultVO insertComment(CommentParam commentParam){
		Comment comment = new Comment();
		comment.setCid(commentParam.getLoginUserId());
		comment.setCrt_Cid(commentParam.getCrtId());
		comment.setFb_id(commentParam.getFb_id());
		comment.setComments(commentParam.getComment());
		int cnt = commentDAO.insertComment(comment);
		ResultVO result = new ResultVO();
		result.put("crtCnt", cnt);
		System.out.println("result : "+result);
		return result;
	}
}
