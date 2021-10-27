package com.petdaon.mvc.member.model.service;


import static com.petdaon.mvc.common.JdbcTemplate.*;
import java.sql.Connection;
import java.util.List;
import java.util.Map;

import com.petdaon.mvc.member.model.dao.MemberDao;
import com.petdaon.mvc.member.model.vo.Member;
 
/**
 * 
 * Service : 업무로직 담당 class
 *
 */
public class MemberService {
	
	private MemberDao memberDao = new MemberDao();

	public Member selectOneMember(String memberId) {
		Connection conn = getConnection();
		Member member = memberDao.selectOneMember(conn, memberId);
		close(conn);
		return member;
	}
	
}

