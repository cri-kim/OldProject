/**
 * 
 */
package com.runtime6.web.common.mvc.model.dto;

import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;

/**
 * Extends User with addition spring security User info.
 * 
 */
public class runtime6User extends User {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	private String name;

	private String cellPhone;
	
	private String email;
		
	private String[] role;
	
	private String idtr;
	
	public runtime6User(String username, String password, boolean enabled, boolean accountNonExpired, boolean credentialsNonExpired, boolean accountNonLocked, List<GrantedAuthority> authorities, 
			String name, String cellPhone, String email, String idtr) {
		super(username, password, enabled, accountNonExpired, credentialsNonExpired, accountNonLocked, authorities);
		this.name = name;
		this.cellPhone = cellPhone;
		this.email = email;
		this.idtr = idtr;
		this.role = new String[authorities.size()];
		for(int i=0; i<authorities.size(); i++) {
			GrantedAuthority grantedAuthority = authorities.get(i);
			role[i] = grantedAuthority.getAuthority();
		}
	}
	
	
	public String getIdtr() {
		return idtr;
	}
	public void setIdtr(String idtr) {
		this.idtr = idtr;
	}
	public String[] getRole() {
		return role;
	}

	public void setRole(String[] role) {
		this.role = role;
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

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
}
