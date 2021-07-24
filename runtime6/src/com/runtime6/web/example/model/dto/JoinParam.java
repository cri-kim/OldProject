package com.runtime6.web.example.model.dto;

import org.hibernate.validator.constraints.Email;
import org.hibernate.validator.constraints.Length;
import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.web.multipart.MultipartFile;

import com.runtime6.web.common.mvc.model.vo.ParameterVO;

public class JoinParam extends ParameterVO {
	@NotEmpty
	@Length(min=6, max=18)
	private String cid;
	@NotEmpty
	@Length(min=6, max=12)
	private String passwd;
	@NotEmpty
	@Length(min=2, max=20, message="이름은 2~20자 이내로 입력하세요.")
	private String name;
	@Length(max=15)
	private String cellPhone;
	@Email
	@Length(max=50)
	private String email;
	
	private String role;
	

	private String sex;
	private String birth;
	private String address;
	private String bank_name;
	private String bank_num;

	private String idtr;
	private String buss_num;
	private String enabled;
	
	private String f_no;
	
	private String img_name;
	private String img_path;
	private String u_id;
	private String u_dttm;
	
	
	private String p_id;
	 private String charge;
	 private String  p_dttm;
	 private String  vender_id;
	 private String  item_num;
	 private String  item_charge;
	 private String  total_charge;
	 private String  item_name;
	 private String  d_id;
	 
	 private String item_f_no;
	 
	 
	
	public String getItem_f_no() {
		return item_f_no;
	}

	public void setItem_f_no(String item_f_no) {
		this.item_f_no = item_f_no;
	}

	public String getP_id() {
		return p_id;
	}

	public void setP_id(String p_id) {
		this.p_id = p_id;
	}

	public String getCharge() {
		return charge;
	}

	public void setCharge(String charge) {
		this.charge = charge;
	}

	public String getP_dttm() {
		return p_dttm;
	}

	public void setP_dttm(String p_dttm) {
		this.p_dttm = p_dttm;
	}

	public String getVender_id() {
		return vender_id;
	}

	public void setVender_id(String vender_id) {
		this.vender_id = vender_id;
	}

	public String getItem_num() {
		return item_num;
	}

	public void setItem_num(String item_num) {
		this.item_num = item_num;
	}

	public String getItem_charge() {
		return item_charge;
	}

	public void setItem_charge(String item_charge) {
		this.item_charge = item_charge;
	}

	public String getTotal_charge() {
		return total_charge;
	}

	public void setTotal_charge(String total_charge) {
		this.total_charge = total_charge;
	}

	public String getItem_name() {
		return item_name;
	}

	public void setItem_name(String item_name) {
		this.item_name = item_name;
	}

	public String getD_id() {
		return d_id;
	}

	public void setD_id(String d_id) {
		this.d_id = d_id;
	}

	private MultipartFile buss_file;
	
	public MultipartFile getBuss_file() {
		return buss_file;
	}

	public void setBuss_file(MultipartFile buss_file) {
		this.buss_file = buss_file;
	}

	public String getEnabled() {
		return enabled;
	}

	public void setEnabled(String enabled) {
		this.enabled = enabled;
	}

	public String getBuss_num() {
		return buss_num;
	}

	public void setBuss_num(String buss_num) {
		this.buss_num = buss_num;
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

	public String getU_id() {
		return u_id;
	}

	public void setU_id(String u_id) {
		this.u_id = u_id;
	}

	public String getU_dttm() {
		return u_dttm;
	}

	public void setU_dttm(String u_dttm) {
		this.u_dttm = u_dttm;
	}

	public String getIdtr() {
		return idtr;
	}

	public void setIdtr(String idtr) {
		this.idtr = idtr;
	}

	public String getSex() {
		return sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	public String getBirth() {
		return birth;
	}

	public void setBirth(String birth) {
		this.birth = birth;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getBank_name() {
		return bank_name;
	}

	public void setBank_name(String bank_name) {
		this.bank_name = bank_name;
	}

	public String getBank_num() {
		return bank_num;
	}

	public void setBank_num(String bank_num) {
		this.bank_num = bank_num;
	}

	public String getF_no() {
		return f_no;
	}

	public void setF_no(String f_no) {
		this.f_no = f_no;
	}

	
	
	
	
	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public String getCid() {
		return cid;
	}

	public void setCid(String cid) {
		this.cid = cid;
	}

	public String getPasswd() {
		return passwd;
	}

	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getCellPhone() {
		return cellPhone;
	}

	public void setCellPhone(String cellPhone) {
		this.cellPhone = cellPhone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
	
}
