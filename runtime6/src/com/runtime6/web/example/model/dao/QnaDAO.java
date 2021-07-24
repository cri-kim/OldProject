package com.runtime6.web.example.model.dao;

import java.util.List;

import com.runtime6.web.example.model.dto.QnaPost;
import com.runtime6.web.example.model.dto.QnaPostParam;

public interface QnaDAO {
	
	public List<QnaPost> getPostList(QnaPostParam param);
	
	public QnaPost getPost(QnaPostParam param);

	public int deletePost(QnaPostParam postParam);

	public int updatePost(QnaPostParam postParam);

	public int insertPost(QnaPost post);
	
	public int replyPost(QnaPost post);
	
	public int replyPostenabled(QnaPost post);
	
	public int getCountPostList(QnaPostParam param);

}
