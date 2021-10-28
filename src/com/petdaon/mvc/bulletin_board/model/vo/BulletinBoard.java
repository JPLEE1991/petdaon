package com.petdaon.mvc.bulletin_board.model.vo;

import java.io.Serializable;
import java.sql.Date;

import com.petdaon.mvc.common.vo.Attachment;

public class BulletinBoard implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private int no;
	private String title;
	private String writer;
	private String content;
	private Date regDate;
	private int readCount;
	
	
	private Attachment attach;



}
