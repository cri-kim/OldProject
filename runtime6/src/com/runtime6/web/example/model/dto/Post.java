package com.runtime6.web.example.model.dto;

import org.json.simple.JSONObject;

public class Post {
	/*
	 * b.B_ID, b.TITLE, u.NAME, b.WRITE_DATE, a.FID, a.FILENAME, a.FILEPATH
	 */
	private String b_id;

	private String title;

	private String content;

	private String name;

	private String write_date;

	private String fid;

	private String filename;

	private String filepath;

	private String userId;

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getB_id() {
		return b_id;
	}

	public void setB_id(String b_id) {
		this.b_id = b_id;
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

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getWrite_date() {
		return write_date;
	}

	public void setWrite_date(String write_date) {
		this.write_date = write_date;
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
	public String getBbsId() {
		return b_id;
	}

	public void setBbsid(String b_id) {
		this.b_id = b_id;
	}
	@Override
	public String toString() {
		JSONObject json = new JSONObject();
		json.put("b_id", b_id);
		json.put("title", title);
		json.put("content", content);
		json.put("name", name);
		json.put("userId", userId);
		json.put("write_date", write_date);
		json.put("fid", fid);
		json.put("filename", filename);
		json.put("filepath", filepath);
		return json.toJSONString();
	}
}
