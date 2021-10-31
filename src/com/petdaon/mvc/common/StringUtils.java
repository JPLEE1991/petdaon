package com.petdaon.mvc.common;

import java.sql.Date;

public class StringUtils {

	/**
	 * null을 ""로 치환.
	 * 문자열을 trim.
	 * 
	 * @param str
	 * @return
	 */
	public static String getString(String str) {
		if (str == null)	return "";
		
		return str.trim();
	}
	
	/**
	 * null을 ""로 치환.
	 * 문자열을 trim.
	 * 
	 * @param str
	 * @return
	 */
	public static String getString(Date date) {
		if (date == null)	return "";
		
		return date.toString();
	}
	
	/**
	 * 문자열이 비어있는지 확인.
	 * 
	 * @param str
	 * @return
	 */
	public static boolean isEmpty(String str) {
		return str == null || "".equals(getString(str)) ? true : false;
	}
}
