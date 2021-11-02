package com.petdaon.mvc.admin.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.petdaon.mvc.common.MvcUtils;
import com.petdaon.mvc.volunteer_board.model.service.VolunteerBoardService;
import com.petdaon.mvc.volunteer_board.model.vo.VolunteerBoard;

/**
 * Servlet implementation class AdiminVolunteerBoardListServlet
 */
@WebServlet("/admin/volunteerBoardList")
public class AdiminVolunteerBoardListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private VolunteerBoardService volunteerBoardService = new VolunteerBoardService();

	/**
	 * Paging 처리
	 * 1. contents영역
	 *  - 1~10, 11~20, 21~30... 시작rownum~끝rownum
	 *  - 현재페이지 cPage, 페이지당게시물수 numPerpage
	 *  
	 * 2. pagebar영역
	 *  - 전체게시물수 totalContents
	 *  - 페이지바크기 pageBarSize
	 *  - 총페이지수
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			// 1.사용자입력값처리
			int cPage = 1; // cPage 현재 페이지
			int numPerPage = 10; // numPerPage 페이지당 게시물 수. 얘는 고정한다. cPage의 경우는 다르다.
			// 만약 cPage가 넘어온게 없다면 null이 되겠죠. 그럼 NumberFormatException예외가 발생한다.
			// 따라서 예외처리한다.
			try {
				cPage = Integer.parseInt(request.getParameter("cPage")); // cPage는 나중의 사용자의 입력값이 넘어올 것이다. int값되야해서 Integer.parseInt()함.
			} catch(NumberFormatException e) {
				// 처리코드 없음.
				// 왜없느냐? 오류가 났어?하면 아까 처리한 cPage값 1 유지. cPage없어도
			}
			//System.out.println("cPage = " + cPage);
			
			int startRownum = cPage * numPerPage - (numPerPage - 1);
			int endRownum = cPage * numPerPage;
			
			// 2. 업무로직
			// a.content영역
			// 총 봉사게시글 리스트 가져오기(삭제여부, 승인여부 가리지 않고 전부 가져온다.)
			List<VolunteerBoard> list = volunteerBoardService.selectAllVolunteerBoardList(startRownum, endRownum);
			System.out.println("list@servlet = " + list); // 최근등록일순
			
			// b.pagebar영역
			int totalContents = volunteerBoardService.selectTotalVolunteerContents(); // 총봉사게시글수
			System.out.println("totalContents@servlet = " + totalContents); // 115
			String url = request.getRequestURI(); // url은 다음번 요청에 대한 url이다. 버튼으로.. 다 링크로 만들건데 그 링크에 url에 해당하는 부분이다.
			String pagebar = MvcUtils.getPagebar(cPage, numPerPage, totalContents, url);
			System.out.println("pagebar@servlet = " + pagebar);
			
			// 3.view단처리
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
