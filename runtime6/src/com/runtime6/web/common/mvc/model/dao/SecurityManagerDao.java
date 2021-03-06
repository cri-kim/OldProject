package com.runtime6.web.common.mvc.model.dao;

import org.springframework.security.core.userdetails.UserDetailsService;

public interface SecurityManagerDao extends UserDetailsService {
	
	public int changePassword(String username, String oldPassword, String newPassword);
}