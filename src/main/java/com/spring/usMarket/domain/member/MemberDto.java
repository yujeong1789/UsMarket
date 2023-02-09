package com.spring.usMarket.domain.member;

import java.util.Date;

public class MemberDto {
	private Integer member_no;
	private String member_name;
	private String member_id;
	private String member_password;
	private String member_image;
	private String member_email;
	private String member_hp;
	private Date member_regdate;
	private Integer member_state_no;
	private String member_nickname;
	private String member_zipcode;
	private String member_address;
	private String member_address_detail;	

	public MemberDto() {}
	
	public MemberDto(Integer member_no, String member_name, String member_id, String member_password,
			String member_image, String member_email, String member_hp, Date member_regdate, Integer member_state_no,
			String member_nickname, String member_zipcode, String member_address, String member_address_detail) {
		this.member_no = member_no;
		this.member_name = member_name;
		this.member_id = member_id;
		this.member_password = member_password;
		this.member_image = member_image;
		this.member_email = member_email;
		this.member_hp = member_hp;
		this.member_regdate = member_regdate;
		this.member_state_no = member_state_no;
		this.member_nickname = member_nickname;
		this.member_zipcode = member_zipcode;
		this.member_address = member_address;
		this.member_address_detail = member_address_detail;
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

	public String getMember_hp() {
		return member_hp;
	}

	public void setMember_hp(String member_hp) {
		this.member_hp = member_hp;
	}

	public Date getMember_regdate() {
		return member_regdate;
	}

	public void setMember_regdate(Date member_regdate) {
		this.member_regdate = member_regdate;
	}

	public Integer getMember_state_no() {
		return member_state_no;
	}

	public void setMember_state_no(Integer member_state_no) {
		this.member_state_no = member_state_no;
	}

	public String getMember_nickname() {
		return member_nickname;
	}

	public void setMember_nickname(String member_nickname) {
		this.member_nickname = member_nickname;
	}

	public String getMember_zipcode() {
		return member_zipcode;
	}

	public void setMember_zipcode(String member_zipcode) {
		this.member_zipcode = member_zipcode;
	}

	public String getMember_address() {
		return member_address;
	}

	public void setMember_address(String member_address) {
		this.member_address = member_address;
	}

	public String getMember_address_detail() {
		return member_address_detail;
	}

	public void setMember_address_detail(String member_address_detail) {
		this.member_address_detail = member_address_detail;
	}

	@Override
	public String toString() {
		return "MemberDto [member_no=" + member_no + ", member_name=" + member_name + ", member_id=" + member_id
				+ ", member_password=" + member_password + ", member_image=" + member_image + ", member_email="
				+ member_email + ", member_hp=" + member_hp + ", member_regdate=" + member_regdate
				+ ", member_state_no=" + member_state_no + ", member_nickname=" + member_nickname + ", member_zipcode="
				+ member_zipcode + ", member_address=" + member_address + ", member_address_detail="
				+ member_address_detail + "]";
	}	

}