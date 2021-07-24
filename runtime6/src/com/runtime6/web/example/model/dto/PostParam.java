package com.runtime6.web.example.model.dto;

import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.web.multipart.MultipartFile;

import com.runtime6.web.common.mvc.model.vo.ParameterVO;

public class PostParam extends ParameterVO{
	private String fid;
	
	private String b_id;

	private String[] searchCondition;

	private String searchText;
	@NotEmpty
	private String title;
	@NotEmpty
	private String content;
	
	private MultipartFile addfile;

	public String getFid() {
		return fid;
	}

	public void setFid(String fid) {
		this.fid = fid;
	}

	public MultipartFile getAddfile() {
		return addfile;
	}

	public void setAddfile(MultipartFile addfile) {
		this.addfile = addfile;
	}

	public String getB_id() {
		return b_id;
	}

	public void setB_id(String b_id) {
		this.b_id = b_id;
	}

	public String[] getSearchCondition() {
		return searchCondition;
	}

	public void setSearchCondition(String[] searchCondition) {
		this.searchCondition = searchCondition;
	}

	public String getSearchText() {
		return searchText;
	}

	public void setSearchText(String searchText) {
		this.searchText = searchText;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

}
