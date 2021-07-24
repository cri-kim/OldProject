package com.runtime6.web.example.model.dto;

import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.web.multipart.MultipartFile;

import com.runtime6.web.common.mvc.model.vo.ParameterVO;

public class FB_PostParam extends ParameterVO{
	private String fid;
	
	private String fb_id;

	private String[] searchCondition;
	private String fb_updId;
	
	private String cid;
	private String searchText;
	@NotEmpty
	private String fb_title;
	@NotEmpty
	private String fb_content;
	
	private MultipartFile addfile;

	
	public String getCid() {
		return cid;
	}

	public void setCid(String cid) {
		this.cid = cid;
	}

	public String getFb_updId() {
		return fb_updId;
	}

	public void setFb_updId(String fb_updId) {
		this.fb_updId = fb_updId;
	}
	public String getFid() {
		return fid;
	}

	public void setFid(String fid) {
		this.fid = fid;
	}

	public String getFb_id() {
		return fb_id;
	}

	public void setFb_id(String fb_id) {
		this.fb_id = fb_id;
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

	public String getFb_title() {
		return fb_title;
	}

	public void setFb_title(String fb_title) {
		this.fb_title = fb_title;
	}

	public String getFb_content() {
		return fb_content;
	}

	public void setFb_content(String fb_content) {
		this.fb_content = fb_content;
	}

	public MultipartFile getAddfile() {
		return addfile;
	}

	public void setAddfile(MultipartFile addfile) {
		this.addfile = addfile;
	}
}