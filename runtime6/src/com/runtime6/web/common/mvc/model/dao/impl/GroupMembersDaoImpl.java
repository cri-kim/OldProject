package com.runtime6.web.common.mvc.model.dao.impl;

import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.stereotype.Repository;

import com.runtime6.web.common.mvc.model.dao.GroupMembersDao;
import com.runtime6.web.common.mvc.model.dto.GroupMember;

@Repository
public class GroupMembersDaoImpl extends SqlSessionDaoSupport implements GroupMembersDao {
	@Override
	public int addUserToGroupMember(GroupMember groupMembers) {
		int result = getSqlSession().update("com.runtime6.example.groupmembers.addUserToGroupMember", groupMembers);
		return result;
	}

	@Override
	public int updateUserLevel(GroupMember groupMembers) {
		int result = getSqlSession().update("com.runtime6.example.groupmembers.updateUserLevel", groupMembers);
		return result;
	}
}
