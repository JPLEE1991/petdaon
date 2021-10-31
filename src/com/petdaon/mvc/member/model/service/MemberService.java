package com.petdaon.mvc.member.model.service;


import static com.petdaon.mvc.common.JdbcTemplate.*;

import java.sql.Connection;
import java.util.List;

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
	public int insertMember(Member member) {
		Connection conn = getConnection();
		int result = 0;
		
		try {
			result =  memberDao.insertMember(conn, member);
			commit(conn);
			
		} catch (Exception e) {
			e.printStackTrace();
			rollback(conn);
			
		} finally {
			close(conn);
		}
		
		return result;
		
	}
	
	/**
	 * 회원목록 조회.
	 * 
	 * @param keyword 검색어
	 * @param start 조회시작 index
	 * @param end 조회종료index
	 * @return 회원목록
	 */
	public List<Member> selectMemberList(String keyword, int start, int end) {
		Connection conn = getConnection();
		List<Member> list 	= null;
		
		try {
			list =  memberDao.selectMemberList(conn, keyword, start, end);
			
		} catch (Exception e) {
			e.printStackTrace(); 
			
		} finally {
			close(conn);
		}
		
		return list;
	}
	
	/**
	 * 회원목록 건수
	 * 
	 * @param keyword
	 * @return
	 */
	public int selectMemberListCount(String keyword) {
		Connection conn = getConnection();
		int count 	= 0;
		
		try {
			count =  memberDao.selectMemberListCount(conn, keyword);
			
		} catch (Exception e) {
			e.printStackTrace();
			
		} finally {
			close(conn);
		}
		
		return count;
	}
	
	/**
	 * 개인회원정보 상세
	 * @param memberId
	 * @return
	 */
	public Member selectMemberView(String memberId) {
		Connection conn = getConnection();
		Member member = null;
		
		try {
			member =  memberDao.selectMemberView(conn, memberId);
			
		} catch (Exception e) {
			e.printStackTrace();
			
		} finally {
			close(conn);
		}
		
		return member;
	
	}
	
	/**
	 * 개인회원정보 수정
	 * @param memberId
	 * @return
	 */
	public int updateMember(Member member) {
		Connection conn = getConnection();
		int count = 0;
		
		try {
			count =  memberDao.updateMember(conn, member);
			commit(conn);
			
		} catch (Exception e) {
			e.printStackTrace();
			rollback(conn);
			
		} finally {
			close(conn);
		}
		
		return count;
	
	}
	
	/**
	 * 회원 블랙
	 * @param memberId
	 * @return
	 */
	public int blackMember(String memberId) {

		Connection conn = getConnection();
		int count = 0;
		
		try {
			count =  memberDao.blackMember(conn, memberId);
			commit(conn);
			
		} catch (Exception e) {
			e.printStackTrace();
			rollback(conn);
			
		} finally {
			close(conn);
		}
		
		return count;
	
	
	}
	
	/**
	 * 회원 탈퇴
	 * @param memberId
	 * @return
	 */
	public int leaveMember(String memberId) {

		Connection conn = getConnection();
		int count = 0;
		
		try {
			count =  memberDao.leaveMember(conn, memberId);
			commit(conn);
			
		} catch (Exception e) {
			e.printStackTrace();
			rollback(conn);
			
		} finally {
			close(conn);
		}
		
		return count;
	
	
	}


}

