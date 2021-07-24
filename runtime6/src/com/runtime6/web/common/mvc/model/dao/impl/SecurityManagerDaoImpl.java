package com.runtime6.web.common.mvc.model.dao.impl;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.security.authentication.encoding.PasswordEncoder;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.jdbc.JdbcDaoImpl;

import com.runtime6.web.common.mvc.model.dao.SecurityManagerDao;
import com.runtime6.web.common.mvc.model.dto.runtime6User;

/**
 * Extends the baseline Spring Security JdbcDaoImpl and load login user from custom user table.
 * 
 */
public class SecurityManagerDaoImpl extends JdbcDaoImpl implements SecurityManagerDao {
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@Override
	public UserDetails createUserDetails(String username, UserDetails userFromUserQuery, List<GrantedAuthority> combinedAuthorities) {
        String returnUsername = userFromUserQuery.getUsername();

        if (!isUsernameBasedPrimaryKey()) {
            returnUsername = username;
        }
        runtime6User customUser = (runtime6User)userFromUserQuery;
        
        return new runtime6User(
        		returnUsername
        		, userFromUserQuery.getPassword()
        		, userFromUserQuery.isEnabled()
        		, true
        		, true
        		, true
        		, combinedAuthorities
        		, customUser.getName()
        		, customUser.getCellPhone()
        		, customUser.getEmail()
        		, customUser.getIdtr()
        		);
	}
	
	@Override
	public List<UserDetails> loadUsersByUsername(String username) {
        return getJdbcTemplate().query(getUsersByUsernameQuery(), new String[] {username}, new RowMapper<UserDetails>() {
            public UserDetails mapRow(ResultSet rs, int rowNum) throws SQLException {
                String username = rs.getString("cid");
                String password = rs.getString("passwd");
                boolean enabled = rs.getBoolean("enabled");
                String name = rs.getString("name");
                String cellPhone = rs.getString("cell_phone");
                String email = rs.getString("email");
                String idtr = rs.getString("idtr");
                return new runtime6User(
                		username
                		, password
                		, enabled
                		, true
                		, true
                		, true
                		, loadUserAuthorities(username)//사용자의 권한을 가져온다.
                		, name
                		, cellPhone
                		, email
                		, idtr
                		);
            }
        });
	}
	
	public int changePassword(String username, String oldPassword, String newPassword) {
		runtime6User user = (runtime6User)loadUserByUsername(username);
		String oldEncodedPassword = passwordEncoder.encodePassword(oldPassword, null);
		String currPassword = user.getPassword();
		int result =  -1;
		if(currPassword.equals(oldEncodedPassword)) {
			String encodedPassword = passwordEncoder.encodePassword(newPassword, null);
			result = getJdbcTemplate().update("UPDATE users SET passwd = ?, updated_dttm = NOW() WHERE cid = ?", encodedPassword, username);
		} 
		
		return result;
	}
	
	public int joinOut(String username, String password) {
		String encodedPassword = passwordEncoder.encodePassword(password, null);
		runtime6User user = (runtime6User)loadUserByUsername(username);
		int result =  -1;
		if(encodedPassword.equals(user.getPassword())) {
			result = getJdbcTemplate().update("UPDATE users SET leave_dttm = NOW(), enabled = 0, updated_dttm = NOW(), updater_id = ? WHERE cid = ?", 
					user.getUsername(), user.getUsername());
		}
		return result;
	}
	
}
