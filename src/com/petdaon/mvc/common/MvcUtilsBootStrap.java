package com.petdaon.mvc.common;


public class MvcUtilsBootStrap {
	
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
			pagebar.append("<ul class='pagination'>\n");
		}
		else {
			pagebar.append("<ul class='pagination'>\n<li class='page-item'><a class='page-link' href='" + url + (pageNo - 1) + "'>prev</a></li>\n");
		}
		
		//2. pageNo
		while(pageNo <= pageEnd && pageNo <= totalPage) {
			if(pageNo == cPage) {
				//현재페이지인 경우 링크제공안함.
				pagebar.append("<li class='page-item active'><span class='cPage page-link'>" + pageNo + "</span></li>\n");
			}
			else {
				//현재페이지가 아닌 경우 링크제공.
				pagebar.append("<li class='page-item'><a class='page-link' href='" + url + pageNo + "'>" + pageNo + "</a></li>\n");
			}
			pageNo++;
		}
		
		//3. 다음
		if(pageNo > totalPage) {
			pagebar.append("</ul>");
		}
		else {
			pagebar.append("<li class='page-item'><a class='page-link' href='" + url + pageNo + "'>next</a></li>\n</ul>\n");
		}
		
		return pagebar.toString();
	}
}
