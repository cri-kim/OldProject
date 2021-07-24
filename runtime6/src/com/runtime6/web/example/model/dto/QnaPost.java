
package com.runtime6.web.example.model.dto;

import org.json.simple.JSONObject;

public class QnaPost {
	/*
	 * b.B_ID, b.TITLE, u.NAME, b.WRITE_DATE, a.FID, a.FILENAME, a.FILEPATH
	 */
	private String q_no;

	private String title;

	private String content;

	private String name;

	private String q_dttm;

	private String enabled;
	private String userId;
	
	private String upd_ymd;
	
	private String qna_updId;
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

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getQ_dttm() {
		return q_dttm;
	}

	public void setQ_dttm(String q_dttm) {
		this.q_dttm = q_dttm;
	}


	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUpd_ymd() {
		return upd_ymd;
	}

	public void setUpd_ymd(String upd_ymd) {
		this.upd_ymd = upd_ymd;
	}

	public String getQna_updId() {
		return qna_updId;
	}

	public void setQna_updId(String qna_updId) {
		this.qna_updId = qna_updId;
	}

	/*	public String getBbsId() {
		return fb_id;
	}

	public void setBbsid(String b_id) {
		this.fb_id = b_id;
	}*/
	@Override
	public String toString() {
		JSONObject json = new JSONObject();
		json.put("q_no", q_no);
		json.put("title", title);
		json.put("content", content);
		json.put("name", name);
		json.put("userId", userId);
		json.put("q_dttm", q_dttm);
		json.put("upd_ymd", upd_ymd);
		return json.toJSONString();
	}

}