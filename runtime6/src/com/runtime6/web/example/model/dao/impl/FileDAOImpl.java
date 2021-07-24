package com.runtime6.web.example.model.dao.impl;

import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.support.JdbcDaoSupport;
import org.springframework.stereotype.Repository;

import com.runtime6.web.example.model.dao.FileDAO;
import com.runtime6.web.example.model.dto.FileInfo;

@Repository
public class FileDAOImpl extends JdbcDaoSupport implements FileDAO {
	@Autowired
	public FileDAOImpl(DataSource dataSource) {
		setDataSource(dataSource);
	}
	public FileInfo getFileInfo(String item_f_no) {
		StringBuffer sql = new StringBuffer();
		sql.append(" SELECT ITEM_F_NO AS item_f_no ");
		sql.append("	,IMG_NAME AS img_name ");
		sql.append("	,IMG_PATH AS img_path ");
		sql.append(" FROM BUSINESS_FILE");
		sql.append(" WHERE ITEM_F_NO = ? ");

		return getJdbcTemplate().queryForObject(sql.toString(),
				new Object[] { item_f_no }, new RowMapper<FileInfo>() {
					@Override
					public FileInfo mapRow(ResultSet rs, int arg1)
							throws SQLException {

						FileInfo fileInfo = new FileInfo();
						fileInfo.setItem_f_no(rs.getString("fid"));
						fileInfo.setImg_name(rs.getString("img_name"));
						fileInfo.setImg_path(rs.getString("img_path"));
						return fileInfo;
					}
				});
	}
}
