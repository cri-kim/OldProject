package com.runtime6.web.example.model.dto;


import org.springframework.web.multipart.MultipartFile;

import com.runtime6.web.common.mvc.model.vo.ParameterVO;

public class BusinessParam extends ParameterVO{
	private String item_no;
	private String item_name;
	private String content;
	private String item_charge;
	private String item_type;
	private String final_date;
	private String start_date;
	private String remainder;
	private String vender_id;
	private String maximum;
	private String minimum;
	private String item_f_no;
	private String img_name;
	private String img_path;
	private String idtr;
	private String refFunc;

					 
	private String[] searchCondition;
	private String searchText;
	private MultipartFile business_file;

	private MultipartFile upload;
	private String CKEditor;
	
	private String CKEditorFuncNum;
	
	private String langCode;	
	
	
	public String getRefFunc() {
		return refFunc;
	}
	public void setRefFunc(String refFunc) {
		this.refFunc = refFunc;
	}
	
	public MultipartFile getUpload() {
		return upload;
	}
	public void setUpload(MultipartFile upload) {
		this.upload = upload;
	}
	public String getCKEditor() {
		return CKEditor;
	}
	public void setCKEditor(String cKEditor) {
		CKEditor = cKEditor;
	}
	public String getCKEditorFuncNum() {
		return CKEditorFuncNum;
	}
	public void setCKEditorFuncNum(String cKEditorFuncNum) {
		CKEditorFuncNum = cKEditorFuncNum;
	}
	public String getLangCode() {
		return langCode;
	}
	public void setLangCode(String langCode) {
		this.langCode = langCode;
	}
	public String getIdtr() {
		return idtr;
	}
	public void setIdtr(String idtr) {
		this.idtr = idtr;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
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
	
	public MultipartFile getBusiness_file() {
		return business_file;
	}
	public void setBusiness_file(MultipartFile business_file) {
		this.business_file = business_file;
	}
	public String getItem_no() {
		return item_no;
	}
	public void setItem_no(String item_no) {
		this.item_no = item_no;
	}
	public String getItem_name() {
		return item_name;
	}
	public void setItem_name(String item_name) {
		this.item_name = item_name;
	}
	public String getItem_charge() {
		return item_charge;
	}
	public void setItem_charge(String item_charge) {
		this.item_charge = item_charge;
	}
	public String getItem_type() {
		return item_type;
	}
	public void setItem_type(String item_type) {
		this.item_type = item_type;
	}
	public String getFinal_date() {
		return final_date;
	}
	public void setFinal_date(String final_date) {
		this.final_date = final_date;
	}
	public String getStart_date() {
		return start_date;
	}
	public void setStart_date(String start_date) {
		this.start_date = start_date;
	}
	
	public String getRemainder() {
		return remainder;
	}
	public void setRemainder(String remainder) {
		this.remainder = remainder;
	}
	public String getVender_id() {
		return vender_id;
	}
	public void setVender_id(String vender_id) {
		this.vender_id = vender_id;
	}
	public String getMaximum() {
		return maximum;
	}
	public void setMaximum(String maximum) {
		this.maximum = maximum;
	}
	public String getMinimum() {
		return minimum;
	}
	public void setMinimum(String minimum) {
		this.minimum = minimum;
	}
	public String getItem_f_no() {
		return item_f_no;
	}
	public void setItem_f_no(String item_f_no) {
		this.item_f_no = item_f_no;
	}
	public String getImg_name() {
		return img_name;
	}
	public void setImg_name(String img_name) {
		this.img_name = img_name;
	}
	public String getImg_path() {
		return img_path;
	}
	public void setImg_path(String img_path) {
		this.img_path = img_path;
	}
	
	

}
