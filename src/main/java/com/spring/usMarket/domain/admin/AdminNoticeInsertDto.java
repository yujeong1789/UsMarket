package com.spring.usMarket.domain.admin;

public class AdminNoticeInsertDto {
	private String notice_no;
	private String admin_no = "";
	private Integer notice_status;
	private String notice_title;
	private String notice_content;
	
	public AdminNoticeInsertDto() {}
	
	public AdminNoticeInsertDto(String notice_no, String admin_no, Integer notice_status, String notice_title,
			String notice_content) {
		this.notice_no = notice_no;
		this.admin_no = admin_no;
		this.notice_status = notice_status;
		this.notice_title = notice_title;
		this.notice_content = notice_content;
	}

	public String getNotice_no() {
		return notice_no;
	}

	public void setNotice_no(String notice_no) {
		this.notice_no = notice_no;
	}

	public String getAdmin_no() {
		return admin_no;
	}

	public void setAdmin_no(String admin_no) {
		this.admin_no = admin_no;
	}

	public Integer getNotice_status() {
		return notice_status;
	}

	public void setNotice_status(Integer notice_status) {
		this.notice_status = notice_status;
	}

	public String getNotice_title() {
		return notice_title;
	}

	public void setNotice_title(String notice_title) {
		this.notice_title = notice_title;
	}

	public String getNotice_content() {
		return notice_content;
	}

	public void setNotice_content(String notice_content) {
		this.notice_content = notice_content;
	}

	@Override
	public String toString() {
		return "AdminNoticeInsertDto [notice_no=" + notice_no + ", admin_no=" + admin_no + ", notice_status="
				+ notice_status + ", notice_title=" + notice_title + ", notice_content=" + notice_content + "]";
	}
}
