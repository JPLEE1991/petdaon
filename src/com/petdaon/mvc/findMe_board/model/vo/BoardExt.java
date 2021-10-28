package com.petdaon.mvc.findMe_board.model.vo;

import java.io.Serializable;
import java.sql.Date;

import com.petdaon.mvc.common.vo.Attachment;

public class BoardExt extends Board implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private int boardCommentCount;

	public BoardExt() {
		super();
		// TODO Auto-generated constructor stub
	}

	

	public BoardExt(String boardCode, int no, String title, String writer, String phone, Date enrollDate, String gender,
			int weight, String color, String character, Date missDate, String content, String status, String deleteYN,
			String compleYN, double latitude, double longitude, String address, String noticeYN, String animalType,
			String breed, Attachment attach) {
		super(boardCode, no, title, writer, phone, enrollDate, gender, weight, color, character, missDate, content, status,
				deleteYN, compleYN, latitude, longitude, address, noticeYN, animalType, breed, attach);
		// TODO Auto-generated constructor stub
	}



	public int getBoardCommentCount() {
		return boardCommentCount;
	}

	public void setBoardCommentCount(int boardCommentCount) {
		this.boardCommentCount = boardCommentCount;
	}



	@Override
	public String toString() {
		return "BoardExt [boardCommentCount=" + boardCommentCount + ", getBoardCode()=" + getBoardCode() + ", getNo()="
				+ getNo() + ", getTitle()=" + getTitle() + ", getWriter()=" + getWriter() + ", getPhone()=" + getPhone()
				+ ", getEnrollDate()=" + getEnrollDate() + ", getGender()=" + getGender() + ", getWeight()="
				+ getWeight() + ", getColor()=" + getColor() + ", getCharacter()=" + getCharacter() + ", getMissDate()="
				+ getMissDate() + ", getContent()=" + getContent() + ", getStatus()=" + getStatus() + ", getDeleteYN()="
				+ getDeleteYN() + ", getCompleYN()=" + getCompleYN() + ", getLatitude()=" + getLatitude()
				+ ", getLongitude()=" + getLongitude() + ", getAddress()=" + getAddress() + ", getNoticeYN()="
				+ getNoticeYN() + ", getAnimalType()=" + getAnimalType() + ", getBreed()=" + getBreed()
				+ ", getAttach()=" + getAttach() + "]";
	}

	



	
	
	
	
	
	
}
