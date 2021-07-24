package com.runtime6.web.example.model.dto;

import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotEmpty;

import com.runtime6.web.common.mvc.model.vo.ParameterVO;

public class CommentParam extends ParameterVO{
	private String cmt_Num;
	@NotEmpty
	private String fb_id;
	@NotEmpty
	@Length(max=200, min=10)
	private String comment;

	public String getCmt_Num() {
		return cmt_Num;
	}

	public void setCmt_Num(String cmt_Num) {
		this.cmt_Num = cmt_Num;
	}

	public String getFb_id() {
		return fb_id;
	}

	public void setFb_id(String fb_id) {
		this.fb_id = fb_id;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}
	
}
