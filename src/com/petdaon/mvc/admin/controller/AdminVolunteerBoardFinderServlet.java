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
import com.petdaon.mvc.volunteer_board.model.service.VolunteerBoardService;
import com.petdaon.mvc.volunteer_board.model.vo.VolunteerBoard;

/**
 * Servlet implementation class AdminVolunteerBoardFinderServlet
 */
@WebServlet("/admin/volunteerBoardFinder")
public class AdminVolunteerBoardFinderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private VolunteerBoardService volunteerBoardService = new VolunteerBoardService();
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			// 1. 사용자입력값처리
			// 어떤 타입?과 어떤 값? 검색할래요에 해당하는 부분
			String searchType = request.getParameter("searchType");
			String searchKeyword = request.getParameter("searchKeyword");
//			System.out.println("searchType = " + searchType);
//			System.out.println("searchKeyword = " + searchKeyword);
			
			int cPage = 1; // cPage 현재 페이지
			int numPerPage = 10; // numPerPage 페이지당 게시물 수. 얘는 고정을 하겠습니다. cPage의 경우는 다르다.
			// 만약 cPage가 넘어온게 없다면 null이 되겠죠. 그럼 NumberFormatException예외가 발생한다.
			// 따라서 예외처리한다.
			try {
				cPage = Integer.parseInt(request.getParameter("cPage")); // cPage는 나중의 사용자의 입력값이 넘어올 것이다. int값되야해서 Integer.parseInt()함.
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
			
			// 2. 업무로직
			//	가. content영역
			// 		아이디, 이름, 성별을 검색하는 경우 sql문
			// 		a. select * from volunteer where writer like '%abc%' and delete_yn = 'N'
			// 		b. select * from volunteer where center_name like '%아름%' and delete_yn = 'N'
			// 		c. select * from volunteer where approval_yn = 'Y' and delete_yn = 'N'
//			List<VolunteerBoard> list = volunteerBoardService.searchMember(searchType, searchKeyword);
			// 위 방법 대신 Map으로 묶어서 가져왔다. 여러개의 파라미터일 경우 묶어서 가져오는것을 추천.
			List<VolunteerBoard> list = volunteerBoardService.searchVolunteerBoard(param);
			//System.out.println(list);
			
			//	나. pagebar 영역
			//	totalContents
			//		a. select count(*) from volunteer where writer like '%abc%' and delete_yn = 'N'
			//		b. select count(*) from volunteer where center_name like '%아름%' and delete_yn = 'N'
			//		c. select count(*) from volunteer where approval_yn = 'Y' and delete_yn = 'N'
			int totalContents = volunteerBoardService.searchVolunteerBoardCount(param); // 총봉사게시글수(삭제된 게시글 제외)
//			System.out.println("totalContents@servlet = " + totalContents);
			String queryString = String.format("?searchType=%s&searchKeyword=%s", searchType, searchKeyword);
			String url = request.getRequestURI() + queryString; // url은 다음번 요청에 대한 url이다. 버튼으로.. 다 링크로 만들건데 그 링크에 url에 해당하는 부분입니다.
			String pagebar = MvcUtilsBootStrap.getPagebar(cPage, numPerPage, totalContents, url); // totalContents는 총 몇개인지
			//System.out.println("pagebar@servlet = " + pagebar);
			
			// 3. view단처리 (html)
			request.setAttribute("list", list);
			request.setAttribute("pagebar", pagebar);
			request
				.getRequestDispatcher("/WEB-INF/views/admin/manage_volunteer/manageVolunteerBoardList.jsp")
				.forward(request, response);
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
