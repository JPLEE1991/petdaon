package com.petdaon.mvc.member.model.dao;

import static com.petdaon.mvc.common.JdbcTemplate.close;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;
import java.util.ResourceBundle;

import com.petdaon.mvc.member.model.vo.Member;

public class MemberDao {

	private Properties prop = new Properties();

	private static ResourceBundle 	BUNDLE 	= null;

	public MemberDao() {
		BUNDLE 	= ResourceBundle.getBundle("sql.member.member-query");

		//		String filepath = MemberDao.class.getResource("/sql/member/member-query.properties").getPath();
		//		try {
		//			prop.load(new FileReader(filepath));
		//		} catch (IOException e) {
		//			e.printStackTrace();
		//		}

	}
	public int insertMember(Connection conn, Member m) throws SQLException {

		int result = 0;

		PreparedStatement pstmt = null;

		String sql = BUNDLE.getString("insertMember");

		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, m.getMemberId());
		pstmt.setString(2, m.getMemberName());
		pstmt.setString(3, m.getPassword());
		pstmt.setString(4, m.getMemberRole());
		pstmt.setDate(5, m.getBirthday());
		pstmt.setString(6, m.getEmail());
		pstmt.setString(7, m.getPhone());
		pstmt.setString(8, m.getStatus());
		pstmt.setString(9, m.getPhoto());

		result = pstmt.executeUpdate();


		return result;
	}
	
	public Member selectOneMember(Connection conn, String memberId) {
		//		String sql = prop.getProperty("selectOneMember");
		String sql = BUNDLE.getString("selectOneMember");

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
	
	/**
	 * 회원목록 조회.
	 * 
	 * @param conn
	 * @param keyword 검색어
	 * @param start 조회시작 index
	 * @param end 조회종료index
	 * @return 회원목록
	 * @throws SQLException
	 */
	public List<Member> selectMemberList(Connection conn, String keyword, int start, int end) throws SQLException {
		List<Member>	list 	= new ArrayList<Member>();
		
		String sql = BUNDLE.getString("selectMemberList");
		
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		Member member = null;

		System.out.println("sql]" + sql);
		
		// 1.PreparedStatment객체 생성 및 미완성쿼리 값대입
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, keyword);
		pstmt.setString(2, keyword);
		pstmt.setInt(3, start);
		pstmt.setInt(4, end);

		// 2.실행 & ResultSet객체 리턴
		rset = pstmt.executeQuery();

		// 3.ResultSet -> Member
		while (rset.next()) {
			String memberId = rset.getString("member_id");
			String memberName = rset.getString("member_name");
			String password = rset.getString("password");
			String memberRole = rset.getString("member_role");
			Date birthday = rset.getDate("birthday");
			String email = rset.getString("email");
			String phone = rset.getString("phone");
			Date enrollDate = rset.getDate("enroll_Date");
			String status = rset.getString("status");
			String warningcount = rset.getString("warning_count");
			String photo = rset.getString("photo");
			Date quitDate = rset.getDate("quit_date");

			member = new Member(memberId, password, memberName, memberRole, birthday, email, phone, enrollDate, status, warningcount, photo, quitDate);
			list.add(member);
		}

		return list;
	}
	
	/**
	 * 목록건수 조회
	 * 
	 * @param conn
	 * @param keyword
	 * @return
	 * @throws SQLException
	 */
	public int selectMemberListCount(Connection conn, String keyword) throws SQLException {
		String sql = BUNDLE.getString("selectMemberListCount");
		int count = 0;
		
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		// 1.PreparedStatment객체 생성 및 미완성쿼리 값대입
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, keyword);
		pstmt.setString(2, keyword);
		
		// 2.실행 & ResultSet객체 리턴
		rset = pstmt.executeQuery();
		
		// 3.ResultSet -> Member
		if(rset.next()) {
			count = rset.getInt(1);
		}
		
		return count;
	}
	
	/**
	 * 개인회원정보 상세
	 * @param conn
	 * @param memberId
	 * @return
	 * @throws SQLException
	 */
	public Member selectMemberView(Connection conn, String memberId) throws SQLException {

		String sql = BUNDLE.getString("selectMemberView");

		PreparedStatement pstmt = null;
		ResultSet rset = null;
		Member member = null;

		// 1.PreparedStatment객체 생성 및 미완성쿼리 값대입
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, memberId);


		// 2.실행 & ResultSet객체 리턴
		rset = pstmt.executeQuery();

		// 3.ResultSet -> Member
		if (rset.next()) {
			String memberName = rset.getString("member_name");
			String password = rset.getString("password");
			String memberRole = rset.getString("member_role");
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

		return member;
	}

	/**
	 * 개인회원정보 수정
	 * @param conn
	 * @param memberId
	 * @return
	 */
	public int updateMember(Connection conn, Member member) throws SQLException {
		String sql = BUNDLE.getString("updateMember");

		PreparedStatement pstmt = null;

		// 1.PreparedStatment객체 생성 및 미완성쿼리 값대입
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, member.getMemberName());
		pstmt.setString(2, member.getMemberRole());
		pstmt.setDate(3, member.getBirthday());
		pstmt.setString(4, member.getEmail());
		pstmt.setString(5, member.getPhone());
		pstmt.setString(6, member.getMemberId());


		// 2.실행 & ResultSet객체 리턴
		int count = pstmt.executeUpdate();
		
		return count;
	}


	/**
	 * 회원 블랙
	 * @param conn
	 * @param userId
	 * @param userPwd
	 * @return
	 */
	public int blackMember(Connection conn, String memberId) throws SQLException {
		String sql = BUNDLE.getString("blackMember");

		PreparedStatement pstmt = null;

		// 1.PreparedStatment객체 생성 및 미완성쿼리 값대입
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, memberId);


		// 2.실행 & ResultSet객체 리턴
		int count = pstmt.executeUpdate();
		
		return count;
	}

	/**
	 * 회원 탈퇴
	 * @param conn
	 * @param userId
	 * @param userPwd
	 * @return
	 */
	public int leaveMember(Connection conn, String memberId) throws SQLException {
		String sql = BUNDLE.getString("leaveMember");

		PreparedStatement pstmt = null;

		// 1.PreparedStatment객체 생성 및 미완성쿼리 값대입
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, memberId);


		// 2.실행 & ResultSet객체 리턴
		int count = pstmt.executeUpdate();
		
		return count;
	}
	
	
	
	
	
	/**
	 * 회원비밀번호 변경
	 * @param conn
	 * @param memberId
	 * @param password
	 * @return
	 */
	
	public int changePwd(Connection conn, String memberId, String password) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("changePwd");
		System.out.println(memberId);
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			pstmt.setString(2, password);

			result = pstmt.executeUpdate();


		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return result;
	}


}
