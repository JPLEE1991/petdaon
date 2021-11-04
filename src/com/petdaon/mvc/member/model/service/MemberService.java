package com.petdaon.mvc.member.model.service;


import static com.petdaon.mvc.common.JdbcTemplate.close;
import static com.petdaon.mvc.common.JdbcTemplate.commit;
import static com.petdaon.mvc.common.JdbcTemplate.getConnection;
import static com.petdaon.mvc.common.JdbcTemplate.rollback;
import static com.petdaon.mvc.common.JdbcTemplate.*;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import com.petdaon.mvc.common.vo.Attachment;
import com.petdaon.mvc.member.model.dao.MemberDao;
import com.petdaon.mvc.member.model.vo.Member;
import com.petdaon.mvc.volunteer_board.model.vo.VolunteerBoard;
 
/**
 * 
 * Service : 업무로직 담당 class
 *
 */
public class MemberService {
	public static final String MEMBER_ROLE = "M";
    public static final String ADMIN_ROLE = "A";

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
	 * 관리자 회원정보 수정
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
	/**
	 * 비밀번호변경
	 * @param member
	 * @return
	 */
    public int updatePassword(Member member) {
    	Connection conn = getConnection();
		int count = 0;
		
		try {
			count =  memberDao.updatePassword(conn, member);
			commit(conn);
			
		} catch (Exception e) {
			e.printStackTrace();
			rollback(conn);
			
		} finally {
			close(conn);
		}
		
		return count;
	
	}
    
	
	public Attachment selectOneAttachment(int no) {
		Connection conn = getConnection();
		Attachment attach = memberDao.selectOneAttachment(conn, no);
		close(conn);
		return attach;
	}
	
    /**
     * 프로필 사진 추가
     * @param member
     * @return
     */
    public int insertAttachment(Member member) {
    	Connection conn = getConnection();
		int count = 0;
		
		try {
			count =  memberDao.insertAttachment(conn, member);
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
     * 프로필사진 삭제
     * @param member
     * @return
     */
	  public int deleteAttachment(Member member) {
    	Connection conn = getConnection();
		int count = 0;
		
		try {
			count =  memberDao.insertAttachment(conn, member);
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
	   * 개인회원정보 수정
	   * @param member
	   * @return
	   */
	  public int updateMemberview(Member member) {
			Connection conn = getConnection();
			int count = 0;
			
			try {
				count =  memberDao.updateMemberview(conn, member);
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
	   * 블랙회원 리스트 조회
	   * @param keyword
	   * @param start
	   * @param end
	   * @return
	   */
		public List<Member> selectMemberBlackList(String keyword, int start, int end) {
			Connection conn = getConnection();
			List<Member> list 	= null;
			
			try {
				list =  memberDao.selectMemberBlackList(conn, keyword, start, end);
				
			} catch (Exception e) {
				e.printStackTrace(); 
				
			} finally {
				close(conn);
			}
			
			return list;
		}
		
		/**
		 * 블랙리스트 회원수
		 * @param keyword
		 * @return
		 */
		public int selectMemberBlackListCount(String keyword) {
			Connection conn = getConnection();
			int count 	= 0;
			
			try {
				count =  memberDao.selectMemberBlackListCount(conn, keyword);
				
			} catch (Exception e) {
				e.printStackTrace();
				
			} finally {
				close(conn);
			}
			
			return count;
		}
		
		/**
		 * 회원 검색
		 * @param param
		 * @return
		 */
		public List<Member> searchMember(Map<String, Object> param) {
			Connection conn = getConnection();
			List<Member> list 	= null;
			
			try {
				list =  memberDao.searchMember(conn, param);
				
			} catch (Exception e) {
				e.printStackTrace(); 
				
			} finally {
				close(conn);
			}
			
			return list;
		}
		
		public int searchMemberCount(Map<String, Object> param) {
			Connection conn = getConnection();
			int totalContent = memberDao.searchMemberCount(conn);
			// 단순조회로 트랜잭션 처리하지 않음
			close(conn);
			return totalContent;
}	
}

