package com.runtime6.web.example.service;

import java.io.BufferedInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.runtime6.web.example.model.dao.QnaDAO;
import com.runtime6.web.example.model.dao.CommentDAO;
import com.runtime6.web.example.model.dto.Paging;
import com.runtime6.web.example.model.dto.QnaPost;
import com.runtime6.web.example.model.dto.QnaPostParam;


@Service
public class QnaService {
	@Autowired
	private QnaDAO qnaDAO;

	@Autowired
	private CommentDAO commentDAO;
	
	public JSONObject getPostList(QnaPostParam param) {
		JSONObject json = new JSONObject();
		List<QnaPost> postList = null;
		
		int count = qnaDAO.getCountPostList(param);
		System.out.println(count);
		Paging paging = new Paging(param.getCurrPageNo(), count);
		System.out.println(param.getCurrPageNo());
		param.setFromRowNum(paging.getFromRowNum());
		param.setToRowNum(paging.getToRowNum());
		
		System.out.println(param.getFromRowNum());
		System.out.println(param.getToRowNum());
		
		if(count>0) {
			postList = qnaDAO.getPostList(param);         
		}
		json.accumulate("paging", paging);
		json.accumulate("postList", postList);
		return json;
	}
	
	public QnaPost getPost(QnaPostParam postparam){
		return qnaDAO.getPost(postparam);
	}
	
	public int deletePost(QnaPostParam postParam) {
		int result = qnaDAO.deletePost(postParam);
		if(result > 0) {
			commentDAO.deleteCommentByB_id(postParam.getQ_no());
		}
		return result;
	}

	public int updatePost(QnaPostParam postParam) {
		return qnaDAO.updatePost(postParam);
	}
	//�몃옖��뀡�쇰줈 臾띠쑝�ㅻ㈃ �쒕Ф�먮㈃ �뚯씪�낅줈���ㅽ뙣�섎㈃ 湲�벑濡앸룄 �ㅽ뙣�섍쾶 �섍린�꾪빐��
	
	
	public int insertPost(QnaPostParam postParam){

		QnaPost post = new QnaPost();
			post.setTitle(postParam.getTitle());
			post.setContent(postParam.getContent());
			post.setUserId(postParam.getLoginUserId());
			return qnaDAO.insertPost(post);
		}
	
	public int replyPost(QnaPostParam postParam){

		QnaPost post = new QnaPost();	
			post.setQ_no(postParam.getQ_no());
			post.setTitle(postParam.getTitle());
			post.setContent(postParam.getContent());
			post.setUserId(postParam.getLoginUserId());
			System.out.println(postParam.getQ_no());
			System.out.println("이쪽은된다");
			return qnaDAO.replyPost(post);
		}
	public int replyPostenabled(QnaPostParam postParam){
		QnaPost post = new QnaPost();
		String str=postParam.getQ_no();
		int a = Integer.parseInt(str)+1;
		System.out.println(a);
		post.setQ_no(str.valueOf(a));
		post.setEnabled(postParam.getEnabled());
		System.out.println(post.getQ_no());
		System.out.println(post.getEnabled());
		System.out.println("여기도된다");
		return qnaDAO.replyPostenabled(post);

	}
	
}
