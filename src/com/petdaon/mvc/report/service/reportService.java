/*
 * package com.kh.report.model.service;
 * 
 * import static com.common.JDBCTemplate.*;
 * 
 * import java.sql.Connection;
 * 
 * import com.kh.report.model.dao.ReportDao; import
 * com.kh.report.model.vo.Report;
 * 
 * public class ReportService {
 * 
 * 
 * public int checkReport(Report r) { Connection conn = getConnection();
 * 
 * int result = new ReportDao().checkReport(conn, r);
 * 
 * close(conn);
 * 
 * return result; }
 * 
 * public int insertReport(Report r) { Connection conn = getConnection();
 * 
 * int result = new ReportDao().insertReport(conn, r);
 * 
 * if(result>0) { commit(conn); }else { rollback(conn); }
 * 
 * close(conn);
 * 
 * return result; }
 * 
 * 
 * 
 * }
 * 
 */