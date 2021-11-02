/*
 * package com.petdaon.mvc.report.controller;
 * 
 * import java.io.IOException; import javax.servlet.ServletException; import
 * javax.servlet.annotation.WebServlet; import javax.servlet.http.HttpServlet;
 * import javax.servlet.http.HttpServletRequest; import
 * javax.servlet.http.HttpServletResponse;
 * 
 * 
 *//**
	 * Servlet implementation class AdminNoticeDetailServlet
	 */
/*
 * @WebServlet("/reportDetailServlet.rp") public class reportDetailServlet
 * extends HttpServlet { private static final long serialVersionUID = 1L;
 * 
 *//**
	 * @see HttpServlet#HttpServlet()
	 */
/*
 * public reportDetailServlet() { super(); // TODO Auto-generated constructor
 * stub }
 * 
 *//**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
/*
 * protected void doGet(HttpServletRequest request, HttpServletResponse
 * response) throws ServletException, IOException {
 * 
 * if(request.getSession().getAttribute("loginUser") != null &&
 * ((LoginUser)request.getSession().getAttribute("loginUser")).getCategory() ==
 * 2) { int rpno = Integer.parseInt(request.getParameter("rpno"));
 * 
 * AdminReport r = new reportDetailServlet().selectAdminReport(rpno);
 * 
 * if(r != null) {
 * 
 * request.setAttribute("r", r); request.setAttribute("pageTitle", "신고내역 상세조회");
 * request.getRequestDispatcher(
 * "../views/admin/manage_report/manageReportDetailView.jsp").forward(request,
 * response);
 * 
 * }else { request.setAttribute("errorMsg", "유효한 게시글이 아닙니다.");
 * request.getRequestDispatcher("../views/admin/common/errorPage.jsp").forward(
 * request, response); }
 * 
 * }else { request.setAttribute("errorMsg", "로그인 후 이용 가능한 서비스 입니다.");
 * request.getRequestDispatcher("../views/admin/common/errorPage.jsp").forward(
 * request, response); }
 * 
 * }
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