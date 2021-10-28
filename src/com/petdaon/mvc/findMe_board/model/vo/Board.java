package com.petdaon.mvc.findMe_board.model.vo;

import java.sql.Date;

import com.petdaon.mvc.common.vo.Attachment;

public class Board {
	private String boardCode;
	private int no;
	private String title;
	private String writer;
	private String phone;
	private Date enrollDate;
	private String gender;
	private int weight;
	private String color;
	private String character;
	private Date missDate;
	private String content;
	private String status;
	private String deleteYN;
	private String compleYN;
	private double latitude;
	private double longitude;
	private String address;
	private String noticeYN;
	private String animalType;
	private String breed;
	
	private Attachment attach;
	
	public Board() {
		super();
		// TODO Auto-generated constructor stub
	}

	public Board(String boardCode, int no, String title, String writer, String phone, Date enrollDate, String gender,
			int weight, String color, String character, Date missDate, String content, String status, String deleteYN,
			String compleYN, double latitude, double longitude, String address, String noticeYN, String animalType,
			String breed, Attachment attach) {
		super();
		this.boardCode = boardCode;
		this.no = no;
		this.title = title;
		this.writer = writer;
		this.phone = phone;
		this.enrollDate = enrollDate;
		this.gender = gender;
		this.weight = weight;
		this.color = color;
		this.character = character;
		this.missDate = missDate;
		this.content = content;
		this.status = status;
		this.deleteYN = deleteYN;
		this.compleYN = compleYN;
		this.latitude = latitude;
		this.longitude = longitude;
		this.address = address;
		this.noticeYN = noticeYN;
		this.animalType = animalType;
		this.breed = breed;
		this.attach = attach;
	}

	public String getBoardCode() {
		return boardCode;
	}

	public void setBoardCode(String boardCode) {
		this.boardCode = boardCode;
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

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public Date getEnrollDate() {
		return enrollDate;
	}

	public void setEnrollDate(Date enrollDate) {
		this.enrollDate = enrollDate;
	}

	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public int getWeight() {
		return weight;
	}

	public void setWeight(int weight) {
		this.weight = weight;
	}

	public String getColor() {
		return color;
	}

	public void setColor(String color) {
		this.color = color;
	}

	public String getCharacter() {
		return character;
	}

	public void setCharacter(String character) {
		this.character = character;
	}

	public Date getMissDate() {
		return missDate;
	}

	public void setMissDate(Date missDate) {
		this.missDate = missDate;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getDeleteYN() {
		return deleteYN;
	}

	public void setDeleteYN(String deleteYN) {
		this.deleteYN = deleteYN;
	}

	public String getCompleYN() {
		return compleYN;
	}

	public void setCompleYN(String compleYN) {
		this.compleYN = compleYN;
	}

	public double getLatitude() {
		return latitude;
	}

	public void setLatitude(double latitude) {
		this.latitude = latitude;
	}

	public double getLongitude() {
		return longitude;
	}

	public void setLongitude(double longitude) {
		this.longitude = longitude;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getNoticeYN() {
		return noticeYN;
	}

	public void setNoticeYN(String noticeYN) {
		this.noticeYN = noticeYN;
	}

	public String getAnimalType() {
		return animalType;
	}

	public void setAnimalType(String animalType) {
		this.animalType = animalType;
	}

	public String getBreed() {
		return breed;
	}

	public void setBreed(String breed) {
		this.breed = breed;
	}

	public Attachment getAttach() {
		return attach;
	}

	public void setAttach(Attachment attach) {
		this.attach = attach;
	}

	@Override
	public String toString() {
		return "Board [boardCode=" + boardCode + ", no=" + no + ", title=" + title + ", writer=" + writer + ", phone="
				+ phone + ", enrollDate=" + enrollDate + ", gender=" + gender + ", weight=" + weight + ", color="
				+ color + ", character=" + character + ", missDate=" + missDate + ", content=" + content + ", status="
				+ status + ", deleteYN=" + deleteYN + ", compleYN=" + compleYN + ", latitude=" + latitude
				+ ", longitude=" + longitude + ", address=" + address + ", noticeYN=" + noticeYN + ", animalType="
				+ animalType + ", breed=" + breed + ", attach=" + attach + "]";
	}
	
}