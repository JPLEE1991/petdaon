package com.petdaon.mvc.admin.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.petdaon.mvc.common.MvcUtilsBootStrap;
import com.petdaon.mvc.member.model.service.MemberService;
import com.petdaon.mvc.member.model.vo.Member;


/**
 * Servlet implementation class AdminMemberFinder
 */
@WebServlet("/admin/memberFinder")
public class AdminMemberFinder extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MemberService memberService = new MemberService();
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		try {
			// 1. 사용자입력값처리
			// 어떤 타입?과 어떤 값? 검색할래요에 해당하는 부분
			String searchType = req.getParameter("searchType");
			String searchKeyword = req.getParameter("searchKeyword");
//			System.out.println("searchType = " + searchType);
//			System.out.println("searchKeyword = " + searchKeyword);
			
			int cPage = 1; // cPage 현재 페이지
			int numPerPage = 10; // numPerPage 페이지당 게시물 수. 얘는 고정을 하겠습니다. cPage의 경우는 다르다.
			// 만약 cPage가 넘어온게 없다면 null이 되겠죠. 그럼 NumberFormatException예외가 발생한다.
			// 따라서 예외처리한다.
			try {
				cPage = Integer.parseInt(req.getParameter("cPage")); // cPage는 나중의 사용자의 입력값이 넘어올 것이다. int값되야해서 Integer.parseInt()함.
			} catch(NumberFormatException e) {
				// 처리코드 없음. 왜없느냐? 오류가 났어?하면 아까 처리한 cPage값 1 유지. cPage없어도
			}
			
			int start = cPage * numPerPage - (numPerPage - 1);
			int end = cPage * numPerPage;
			
			Map<String, Object> param = new HashMap<>();
			param.put("searchType", searchType);
			param.put("searchKeyword", searchKeyword);
			param.put("start", start);
			param.put("end", end);
			//System.out.println("param@servlet = " + param);
			
			
			List<Member> list = memberService.searchMember(param);
			//System.out.println(list);
			
			//	나. pagebar 영역
			int totalContents = memberService.searchMemberCount(param);
//			System.out.println("totalContents@servlet = " + totalContents);
			String queryString = String.format("?searchType=%s&searchKeyword=%s", searchType, searchKeyword);
			String url = req.getRequestURI() + queryString; 
			String pagebar = MvcUtilsBootStrap.getPagebar(cPage, numPerPage, totalContents, url); // totalContents는 총 몇개인지
			//System.out.println("pagebar@servlet = " + pagebar);
			
			// 3. view단처리 (html)
			req.setAttribute("list", list);
			req.setAttribute("pagebar", pagebar);
			req
				.getRequestDispatcher("/WEB-INF/views/admin/adminmemberList.jsp")
				.forward(req, res);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
