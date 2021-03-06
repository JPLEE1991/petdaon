package com.petdaon.mvc.common;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;
import java.util.Base64.Encoder;

public class MvcUtils {
	/**
	 * 1. 단방향암호화
	 * 	- 입력값을 고정길이의 hash값으로 출력. hash값에서 입력값을 유추할 수 없다.
	 *  - md5, sha1(160byte), sha256, sha512...
	 *  
	 * 2. 64개 문자열 인코딩
	 * 	- 알파벳대소문자, 숫자, +, / 64개 문자를 이용해 인코딩처리. 
	 *  - ==는 끝을 의미하는 문자.
	 * 
	 * 
	 * @param password
	 * @return
	 */
	public static String getEncryptedPassword(String password) {
		//1.암호화
		MessageDigest md = null;
		byte[] encrypted = null;
		try {
			md = MessageDigest.getInstance("SHA-512");
			byte[] input = password.getBytes("utf-8");
			md.update(input);
			encrypted = md.digest();
		} catch (NoSuchAlgorithmException | UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		System.out.println("암호화 전 : " + password);
		System.out.println("암호화된 이진데이터 : " + new String(encrypted));
		
		//2.인코딩
		Encoder encoder = Base64.getEncoder();
		String encryptedPassword = encoder.encodeToString(encrypted);
		System.out.println("암호화 후 : " + encryptedPassword);
		
		return encryptedPassword;
	}
	
	/**
	 * @param cPage
	 * @param numPerPage
	 * @param totalContents
	 * @param url
	 * @return
	 */
	public static String getPagebar(int cPage, int numPerPage, int totalContents, String url) {
		StringBuilder pagebar = new StringBuilder();
		
		//전체 페이지수
		int totalPage = (int) Math.ceil((double) totalContents / numPerPage); // 113/10
		
		//페이지번호를 클릭했을때 링크
		String delimeter = url.contains("?") ? "&" : "?";
		url = url + delimeter + "cPage="; // /mvc/petdaon/noticeBoard/noticeBoardList?cPage=
		
		//페이지바 크기
		int pagebarSize = 5;
		
		/*
		 
		     1 2 3 4 5 다음
		     
		 이전 6 7 8 9 10 다음
		 
		 이전 11 12
		 
		 pageStart : 시작하는 pageNo
		 	- cPage와 pagebarSize에 의해 결정
		 
		 */
		int pageStart = (cPage - 1) / pagebarSize * pagebarSize + 1; //자바의 정수연산에 의한 계산
		int pageEnd = pageStart + pagebarSize - 1;
		
		int pageNo = pageStart;
		
		/*
		 	이전영역 없음
		 	
		 	pageNo
		    <a href='/mvc/admin/memberList?cPage=1'>1</a>
			<span class='cPage'>2</span>
			<a href='/mvc/admin/memberList?cPage=3'>3</a>
			<a href='/mvc/admin/memberList?cPage=4'>4</a>
			<a href='/mvc/admin/memberList?cPage=5'>5</a>
			
			다음
			<a href='/mvc/admin/memberList?cPage=6'>next</a>
		 */
		
		//1. 이전
		if(pageNo == 1) {
			//pageNo가 6일때부터 생성
		}
		else {
			pagebar.append("<a href='" + url + (pageNo - 1) + "'><span class=\"material-icons-round\">chevron_left</span></a>\n");
		}
		
		//2. pageNo
		while(pageNo <= pageEnd && pageNo <= totalPage) {
			if(pageNo == cPage) {
				//현재페이지인 경우 링크제공안함.
				pagebar.append("<a class='cPage'>" + pageNo + "</a>\n");
			}
			else {
				//현재페이지가 아닌 경우 링크제공.
				pagebar.append("<a href='" + url + pageNo + "'>" + pageNo + "</a>\n");
			}
			pageNo++;
		}
		
		//3. 다음
		if(pageNo > totalPage) {
			
		}
		else {
			pagebar.append("<a href='" + url + pageNo + "'><span class=\"material-icons-round\">chevron_right</span></a>\n");
		}
		
		return pagebar.toString();
	}

	/**
	 * XSS공격대비 < > escaping처리
	 * 
	 * @param s
	 * @return
	 */
	public static String escapeHtml(String s) {
		return s.replaceAll("<", "&lt;").replaceAll(">","&gt;");
	}

	/**
	 * \n 문자 br태그로 변환
	 *  
	 * @param s
	 * @return
	 */
	public static String convertLineFeedToBr(String s) {
		return s.replaceAll("\\n", "<br/>");
	}
}
