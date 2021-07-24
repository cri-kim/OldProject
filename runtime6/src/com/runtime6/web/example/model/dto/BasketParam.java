package com.runtime6.web.example.model.dto;

import org.hibernate.validator.constraints.NotEmpty;

import com.runtime6.web.common.mvc.model.vo.ParameterVO;

public class BasketParam extends ParameterVO {
   @NotEmpty
   private String[] vender_id;
   @NotEmpty
   private String[] item_charge;
   @NotEmpty
   private String[] item_name;
//   @NotEmpty
   private String total_charge;
//   @NotEmpty   
   private String[] item_num;
 
   private String c_no;

   private String[] remainder;
   private String[] item_no;
   private String[] item_f_no;
   
   
   public String[] getItem_f_no() {
	return item_f_no;
}
public void setItem_f_no(String[] item_f_no) {
	this.item_f_no = item_f_no;
}
public String[] getItem_no() {
	return item_no;
}
public void setItem_no(String[] item_no) {
	this.item_no = item_no;
}
public String[] getRemainder() {
	return remainder;
	}
	public void setRemainder(String[] remainder) {
		this.remainder = remainder;
	}
public String[] getVender_id() {
      return vender_id;
   }
   public void setVender_id(String[] vender_id) {
      this.vender_id = vender_id;
   }
   public String[] getItem_charge() {
      return item_charge;
   }
   public void setItem_charge(String[] item_charge) {
      this.item_charge = item_charge;
   }
   public String[] getItem_name() {
      return item_name;
   }
   public void setItem_name(String[] item_name) {
      this.item_name = item_name;
   }
   public String getTotal_charge() {
      return total_charge;
   }
   public void setTotal_charge(String total_charge) {
      this.total_charge = total_charge;
   }
   public String[] getItem_num() {
      return item_num;
   }
   public void setItem_num(String[] item_num) {
      this.item_num = item_num;
   }
   public String getC_no() {
      return c_no;
   }
   public void setC_no(String c_no) {
      this.c_no = c_no;
   }
   

}