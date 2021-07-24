package com.runtime6.web.example.model.dto;

import org.json.simple.JSONObject;

public class FB_Post {
	/*
	 * b.B_ID, b.TITLE, u.NAME, b.WRITE_DATE, a.FID, a.FILENAME, a.FILEPATH
	 */
	private String fb_id;

	private String fb_title;

	private String fb_content;

	private String name;
	private String cid;
	
	public String getCid() {
		return cid;
	}

	public void setCid(String cid) {
		this.cid = cid;
	}

	public String getFb_id() {
		return fb_id;
	}

	public void setFb_id(String fb_id) {
		this.fb_id = fb_id;
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

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getFb_write_date() {
		return fb_write_date;
	}

	public void setFb_write_date(String fb_write_date) {
		this.fb_write_date = fb_write_date;
	}

	public String getFid() {
		return fid;
	}

	public void setFid(String fid) {
		this.fid = fid;
	}

	public String getFilename() {
		return filename;
	}

	public void setFilename(String filename) {
		this.filename = filename;
	}

	public String getFilepath() {
		return filepath;
	}

	public void setFilepath(String filepath) {
		this.filepath = filepath;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUpdDttm() {
		return updDttm;
	}

	public void setUpdDttm(String updDttm) {
		this.updDttm = updDttm;
	}
	private String fb_write_date;

	private String fid;

	private String filename;

	private String filepath;

	private String userId;
	
	private String updDttm;

	public String getBbsId() {
		return fb_id;
	}

	public void setBbsid(String b_id) {
		this.fb_id = b_id;
	}
	@Override
	public String toString() {
		JSONObject json = new JSONObject();
		json.put("b_id", fb_id);
		json.put("title", fb_title);
		json.put("content", fb_content);
		json.put("name", name);
		json.put("userId", userId);
		json.put("write_date", fb_write_date);
		json.put("fid", fid);
		json.put("filename", filename);
		json.put("filepath", filepath);
		return json.toJSONString();
	}

}