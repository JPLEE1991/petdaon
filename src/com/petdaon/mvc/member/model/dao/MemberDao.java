package com.petdaon.mvc.member.model.dao;

import static com.petdaon.mvc.common.JdbcTemplate.close;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

import com.petdaon.mvc.member.model.dao.MemberDao;
import com.petdaon.mvc.member.model.vo.Member;

public class MemberDao {

private Properties prop = new Properties();
	
	public MemberDao() {
		String filepath = MemberDao.class.getResource("/sql/member/member-query.properties").getPath();
		try {
			prop.load(new FileReader(filepath));
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
	public Member selectOneMember(Connection conn, String memberId) {
		String sql = prop.getProperty("selectOneMember");
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		Member member = null;
		
		try {
			// 1.PreparedStatment객체 생성 및 미완성쿼리 값대입
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			
			// 2.실행 & ResultSet객체 리턴
			rset = pstmt.executeQuery();
			
			// 3.ResultSet -> Member
			if(rset.next()) {
				String password = rset.getString("password");
				String memberName = rset.getString("member_Name");
				String memberRole = rset.getString("member_Role");
				Date birthday = rset.getDate("birthday");
				String email = rset.getString("email");
				String phone = rset.getString("phone");
				Date enrollDate = rset.getDate("enroll_Date");
				String status = rset.getString("status");
				String warningcount = rset.getString("warning_count");
				String photo = rset.getString("photo");
				Date quitDate = rset.getDate("quit_date");
				
				member = new Member(memberId, password, memberName, memberRole, birthday, email, phone, enrollDate, status, warningcount, photo, quitDate);
						
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			// 4.자원 반납
			close(rset);
			close(pstmt);
		}
		
		return member;
	}

}
