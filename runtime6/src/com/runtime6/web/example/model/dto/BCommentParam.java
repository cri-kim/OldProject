package com.runtime6.web.example.model.dto;

import com.runtime6.web.common.mvc.model.vo.ParameterVO;

public class BCommentParam extends ParameterVO{
	private String item_no;
	private String cmt_num;
	private String comment;
	private String cid;
	private String crt_dttm;
	private String crt_cid;
	public String getItem_no() {
		return item_no;
	}
	public void setItem_no(String item_no) {
		this.item_no = item_no;
	}
	public String getCmt_num() {
		return cmt_num;
	}
	public void setCmt_num(String cmt_num) {
		this.cmt_num = cmt_num;
	}
	
	public String getComment() {
		return comment;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public String getCid() {
		return cid;
	}
	public void setCid(String cid) {
		this.cid = cid;
	}
	public String getCrt_dttm() {
		return crt_dttm;
	}
	public void setCrt_dttm(String crt_dttm) {
		this.crt_dttm = crt_dttm;
	}
	public String getCrt_cid() {
		return crt_cid;
	}
	public void setCrt_cid(String crt_cid) {
		this.crt_cid = crt_cid;
	}
	public String getUpd_dttm() {
		return upd_dttm;
	}
	public void setUpd_dttm(String upd_dttm) {
		this.upd_dttm = upd_dttm;
	}
	public String getUpd_cid() {
		return upd_cid;
	}
	public void setUpd_cid(String upd_cid) {
		this.upd_cid = upd_cid;
	}
	private String upd_dttm;
	private String upd_cid;

}
