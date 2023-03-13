package com.spring.usMarket.domain.admin;

public class AdminDto {
	private Integer admin_no;
	private String admin_id;
	private String admin_name;
	private String admin_password;
	
	public AdminDto() {}
	
	public AdminDto(Integer admin_no, String admin_id, String admin_name, String admin_password) {
		this.admin_no = admin_no;
		this.admin_id = admin_id;
		this.admin_name = admin_name;
		this.admin_password = admin_password;
	}

	public Integer getAdmin_no() {
		return admin_no;
	}

	public void setAdmin_no(Integer admin_no) {
		this.admin_no = admin_no;
	}

	public String getAdmin_id() {
		return admin_id;
	}

	public void setAdmin_id(String admin_id) {
		this.admin_id = admin_id;
	}

	public String getAdmin_name() {
		return admin_name;
	}

	public void setAdmin_name(String admin_name) {
		this.admin_name = admin_name;
	}

	public String getAdmin_password() {
		return admin_password;
	}

	public void setAdmin_password(String admin_password) {
		this.admin_password = admin_password;
	}

	@Override
	public String toString() {
		return "AdminDto [admin_no=" + admin_no + ", admin_id=" + admin_id + ", admin_name=" + admin_name
				+ ", admin_password=" + admin_password + "]";
	}
}
