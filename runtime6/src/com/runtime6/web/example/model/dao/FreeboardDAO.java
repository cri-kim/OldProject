package com.runtime6.web.example.model.dao;

import java.util.List;

import com.runtime6.web.example.model.dto.FB_Post;
import com.runtime6.web.example.model.dto.FB_PostParam;

public interface FreeboardDAO {
	
	public List<FB_Post> getPostList(FB_PostParam param);
	
	public FB_Post getPost(FB_PostParam param);

	public int deletePost(FB_PostParam postParam);

	public int updatePost(FB_PostParam postParam);

	public int insertPost(FB_Post post);

	public int insertAttachFile(FB_Post post);

	public int getCountPostList(FB_PostParam param);

}
