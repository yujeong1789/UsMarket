package com.spring.usMarket.member.domain;

import java.util.Date;

public class MemberDto {
	private Integer member_no;
	private String member_name;
	private String member_id;
	private String member_password;
	private String member_image;
	private String member_email;
	private String member_hp1;
	private String member_hp2;
	private String member_hp3;
	private Date member_regdate;
	private Integer member_stateNo;
	private String member_nick;
	
	
	public MemberDto() {}


	public MemberDto(Integer member_no, String member_name, String member_id, String member_password,
			String member_image, String member_email, String member_hp1, String member_hp2, String member_hp3,
			Date member_regdate, Integer member_stateNo, String member_nick) {
		super();
		this.member_no = member_no;
		this.member_name = member_name;
		this.member_id = member_id;
		this.member_password = member_password;
		this.member_image = member_image;
		this.member_email = member_email;
		this.member_hp1 = member_hp1;
		this.member_hp2 = member_hp2;
		this.member_hp3 = member_hp3;
		this.member_regdate = member_regdate;
		this.member_stateNo = member_stateNo;
		this.member_nick = member_nick;
	}
	

	public Integer getMember_no() {
		return member_no;
	}


	public void setMember_no(Integer member_no) {
		this.member_no = member_no;
	}


	public String getMember_name() {
		return member_name;
	}


	public void setMember_name(String member_name) {
		this.member_name = member_name;
	}


	public String getMember_id() {
		return member_id;
	}


	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}


	public String getMember_password() {
		return member_password;
	}


	public void setMember_password(String member_password) {
		this.member_password = member_password;
	}


	public String getMember_image() {
		return member_image;
	}


	public void setMember_image(String member_image) {
		this.member_image = member_image;
	}


	public String getMember_email() {
		return member_email;
	}


	public void setMember_email(String member_email) {
		this.member_email = member_email;
	}


	public String getMember_hp1() {
		return member_hp1;
	}


	public void setMember_hp1(String member_hp1) {
		this.member_hp1 = member_hp1;
	}


	public String getMember_hp2() {
		return member_hp2;
	}


	public void setMember_hp2(String member_hp2) {
		this.member_hp2 = member_hp2;
	}


	public String getMember_hp3() {
		return member_hp3;
	}


	public void setMember_hp3(String member_hp3) {
		this.member_hp3 = member_hp3;
	}


	public Date getMember_regdate() {
		return member_regdate;
	}


	public void setMember_regdate(Date member_regdate) {
		this.member_regdate = member_regdate;
	}


	public Integer getMember_stateNo() {
		return member_stateNo;
	}


	public void setMember_stateNo(Integer member_stateNo) {
		this.member_stateNo = member_stateNo;
	}


	public String getMember_nick() {
		return member_nick;
	}


	public void setMember_nick(String member_nick) {
		this.member_nick = member_nick;
	}
	
	
	
	@Override
	public String toString() {
		return "MemberDto [member_no=" + member_no + ", member_name=" + member_name + ", member_id=" + member_id
				+ ", member_password=" + member_password + ", member_image=" + member_image + ", member_email="
				+ member_email + ", member_hp1=" + member_hp1 + ", member_hp2=" + member_hp2 + ", member_hp3="
				+ member_hp3 + ", member_regdate=" + member_regdate + ", member_stateNo=" + member_stateNo
				+ ", member_nick=" + member_nick + "]";
	}


}
