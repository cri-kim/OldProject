package com.runtime6.web.example.model.dto;

import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.web.multipart.MultipartFile;

import com.runtime6.web.common.mvc.model.vo.ParameterVO;

public class QnaPostParam extends ParameterVO{
	private String fid;
	
	private String q_no;

	private String enabled;
	
	private String[] searchCondition;

	private String searchText;
	@NotEmpty
	private String title;
	@NotEmpty
	private String content;
	
	private String userId;
	
	private MultipartFile addfile;
	private String cid;
	
	
	
	
	public String getCid() {
		return cid;
	}

	public void setCid(String cid) {
		this.cid = cid;
	}

	public String getEnabled() {
		return enabled;
	}

	public void setEnabled(String enabled) {
		this.enabled = enabled;
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

	public MultipartFile getAddfile() {
		return addfile;
	}

	public void setAddfile(MultipartFile addfile) {
		this.addfile = addfile;
	}

	public String getFid() {
		return fid;
	}

	public void setFid(String fid) {
		this.fid = fid;
	}

	public String getQ_no() {
		return q_no;
	}

	public void setQ_no(String q_no) {
		this.q_no = q_no;
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

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}


}