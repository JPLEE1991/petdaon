/*
 * package com.petdaon.mvc.report.controller;
 * 
 * import java.io.IOException;
 * 
 * import javax.servlet.ServletException; import
 * javax.servlet.annotation.WebServlet; import javax.servlet.http.HttpServlet;
 * import javax.servlet.http.HttpServletRequest; import
 * javax.servlet.http.HttpServletResponse;
 * 
 * 
 * 
 *//**
	 * Servlet implementation class AdminCommunityDeleteServlet
	 */
/*
 * 
 * @WebServlet("/reportDeletsServlet.rp") public class reportDeleteServlet
 * extends HttpServlet { private static final long serialVersionUID = 1L;
 * 
 *//**
	 * @see HttpServlet#HttpServlet()
	 */
/*
 * 
 * public reportDeleteServlet() { super(); // TODO Auto-generated constructor
 * stub }
 * 
 *//**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
/*
 * 
 * protected void doGet(HttpServletRequest request, HttpServletResponse
 * response) throws ServletException, IOException {
 * 
 * if(request.getSession().getAttribute("loginUser") != null &&
 * ((LoginUser)request.getSession().getAttribute("loginUser")).getCategory() ==
 * 2) { String[] rno = request.getParameterValues("rno");
 * 
 * int result = new reportDeleteServlet().deleteReport(rno);
 * 
 * if(result>0) { request.getSession().setAttribute("alertMsg", "신고 글 삭제 성공");
 * response.sendRedirect(request.getContextPath() +
 * "/adminPage/list.rp?currentPage=1");
 * 
 * }else { request.setAttribute("errorMsg", "신고 글 삭제 실패");
 * request.getRequestDispatcher("../views/admin/common/errorPage.jsp").forward(
 * request, response); }
 * 
 * }else { request.setAttribute("errorMsg", "로그인 후 이용 가능한 서비스 입니다.");
 * request.getRequestDispatcher("../views/admin/common/errorPage.jsp").forward(
 * request, response); } }
 * 
 *//**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 *//*
		 * protected void doPost(HttpServletRequest request, HttpServletResponse
		 * response) throws ServletException, IOException { // TODO Auto-generated
		 * method stub doGet(request, response); }
		 * 
		 * }
		 */