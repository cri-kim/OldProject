package com.runtime6.web.example.service;

import java.io.BufferedInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.runtime6.web.example.model.dao.FreeboardDAO;
import com.runtime6.web.example.model.dao.CommentDAO;
import com.runtime6.web.example.model.dto.Paging;
import com.runtime6.web.example.model.dto.FB_Post;
import com.runtime6.web.example.model.dto.FB_PostParam;
import com.runtime6.web.example.model.dto.Post;
import com.runtime6.web.example.model.dto.PostParam;


@Service
public class FreeboardService {
	@Autowired
	private FreeboardDAO freeboardDAO;

	@Autowired
	private CommentDAO commentDAO;
	
	
	@Value("#{runtime6Prop['file.upload.dir']}")
	private String fileDir;
	
	public JSONObject getPostList(FB_PostParam param) {
		JSONObject json = new JSONObject();
		List<FB_Post> postList = null;
		
		int count = freeboardDAO.getCountPostList(param);
		System.out.println(count);
		Paging paging = new Paging(param.getCurrPageNo(), count);
		System.out.println(param.getCurrPageNo());
		param.setFromRowNum(paging.getFromRowNum());
		param.setToRowNum(paging.getToRowNum());
		
		System.out.println(param.getFromRowNum());
		System.out.println(param.getToRowNum());
		
		if(count>0) {
			postList = freeboardDAO.getPostList(param);         
		}
		json.accumulate("paging", paging);
		json.accumulate("postList", postList);
		return json;
	}
	
	public FB_Post getPost(FB_PostParam postparam){
		return freeboardDAO.getPost(postparam);
	}
	@Transactional
	public int deletePost(FB_PostParam postParam) {
		int result = freeboardDAO.deletePost(postParam);
		if(result > 0) {
			commentDAO.deleteCommentByB_id(postParam.getFb_id());
		}
		return result;
	}

	public int updatePost(FB_PostParam postParam) {
		return freeboardDAO.updatePost(postParam);
	}

	//?????????????????? ???????????? ???????????? ??????????????? ???????????? ???????????? ???????????? ???????????????
	
	@Transactional
	public int insertPost(FB_PostParam postParam) throws IOException {
		
		String name = postParam.getAddfile().getOriginalFilename();
		System.out.println(postParam.getAddfile().getOriginalFilename());
		
		System.out.println("name : "+name);
		boolean hasFile = name != null && !"".equals(name);
		int result = -1;
		FB_Post post = new FB_Post();
		
		if(hasFile) {
			String fileName = null;
			if(postParam.getFb_title().length() < 5){
				fileName = postParam.getFb_title();
			}else {
				fileName = postParam.getFb_title().substring(0,5);
			}
			post.setFilename(fileName);
			post.setFilepath(postParam.getAddfile().getOriginalFilename());
			//????????? ????????? ?????????.
			result = freeboardDAO.insertAttachFile(post);
		}
		
		//?????? ?????? ????????? ??????????????????.
		//????????? ????????? ?????? ?????? ?????? ?????????????????? ?????? ???????????? ????????? ????????? ?????????.
		//??????????????? fid??? ??????.
		if(result > 0 || result == -1) {
			post.setFb_title(postParam.getFb_title());
			post.setFb_content(postParam.getFb_content());
			post.setUserId(postParam.getLoginUserId());
			result = freeboardDAO.insertPost(post);
		}
		
		if(result > 0 && hasFile) {
			//???????????? ??????  ????????? ??????????????? ??????
//				String fileDir="d:\\upload\\";
				FileOutputStream fos = new FileOutputStream(fileDir + name);
				InputStream is = postParam.getAddfile().getInputStream();
				BufferedInputStream bis = new BufferedInputStream(is);
				byte[] buffer = new byte[2048];
				while(bis.read(buffer) != -1) {
					fos.write(buffer);
				}
				fos.close();
			}
		System.out.println("result : "+ result);
		return result;
	}
	
	
	
	
	
}
