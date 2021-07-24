package com.runtime6.web.common.mvc.model.dao;

import com.runtime6.web.common.mvc.model.dto.GroupMember;

public interface GroupMembersDao {
	public int addUserToGroupMember(GroupMember groupMembers);
	
	public int updateUserLevel(GroupMember GroupMember);
}
