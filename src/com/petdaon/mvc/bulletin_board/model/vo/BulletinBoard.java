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
	private Date regDate;  // enroll_date
	private int readCount;  // view_num
	private int scrapCount;  // scrap_num
	private int likeCount;  // like_num
	private String animal; // animal_type
	private String detail;
	private String category;
	private String delete;
	private String notice;
	
	private Attachment attach;

	public BulletinBoard() {
		super();
		// TODO Auto-generated constructor stub
	}

	public BulletinBoard(int no, String title, String writer, String content, Date regDate, int readCount,
			int scrapCount, int likeCount, String animal, String detail, String category, String delete, String notice,
			Attachment attach) {
		super();
		this.no = no;
		this.title = title;
		this.writer = writer;
		this.content = content;
		this.regDate = regDate;
		this.readCount = readCount;
		this.scrapCount = scrapCount;
		this.likeCount = likeCount;
		this.animal = animal;
		this.detail = detail;
		this.category = category;
		this.delete = delete;
		this.notice = notice;
		this.attach = attach;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	public int getReadCount() {
		return readCount;
	}

	public void setReadCount(int readCount) {
		this.readCount = readCount;
	}

	public int getScrapCount() {
		return scrapCount;
	}

	public void setScrapCount(int scrapCount) {
		this.scrapCount = scrapCount;
	}

	public int getLikeCount() {
		return likeCount;
	}

	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}

	public String getAnimal() {
		return animal;
	}

	public void setAnimal(String animal) {
		this.animal = animal;
	}

	public String getDetail() {
		return detail;
	}

	public void setDetail(String detail) {
		this.detail = detail;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getDelete() {
		return delete;
	}

	public void setDelete(String delete) {
		this.delete = delete;
	}

	public String getNotice() {
		return notice;
	}

	public void setNotice(String notice) {
		this.notice = notice;
	}

	public Attachment getAttach() {
		return attach;
	}

	public void setAttach(Attachment attach) {
		this.attach = attach;
	}

	@Override
	public String toString() {
		return "BulletinBoard [no=" + no + ", title=" + title + ", writer=" + writer + ", content=" + content
				+ ", regDate=" + regDate + ", readCount=" + readCount + ", scrapCount=" + scrapCount + ", likeCount="
				+ likeCount + ", animal=" + animal + ", detail=" + detail + ", category=" + category + ", delete="
				+ delete + ", notice=" + notice + ", attach=" + attach + "]";
	}


}
