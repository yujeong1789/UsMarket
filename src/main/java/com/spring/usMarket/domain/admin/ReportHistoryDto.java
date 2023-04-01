package com.spring.usMarket.domain.admin;

public class ReportHistoryDto {
	private String report_no;
	private String admin_no;
	private String member_no;
	private Integer sanction_category_no;
	private String sanction_startdate = "";
	private String sanction_enddate = "";
	
	public ReportHistoryDto() {}
	
	public ReportHistoryDto(String report_no, String admin_no, String member_no, Integer sanction_category_no,
			String sanction_startdate, String sanction_enddate) {
		this.report_no = report_no;
		this.admin_no = admin_no;
		this.member_no = member_no;
		this.sanction_category_no = sanction_category_no;
		this.sanction_startdate = sanction_startdate;
		this.sanction_enddate = sanction_enddate;
	}
	
	public String getReport_no() {
		return report_no;
	}
	public void setReport_no(String report_no) {
		this.report_no = report_no;
	}
	public String getAdmin_no() {
		return admin_no;
	}
	public void setAdmin_no(String admin_no) {
		this.admin_no = admin_no;
	}
	public String getMember_no() {
		return member_no;
	}
	public void setMember_no(String member_no) {
		this.member_no = member_no;
	}
	public Integer getSanction_category_no() {
		return sanction_category_no;
	}
	public void setSanction_category_no(Integer sanction_category_no) {
		this.sanction_category_no = sanction_category_no;
	}
	public String getSanction_startdate() {
		return sanction_startdate;
	}
	public void setSanction_startdate(String sanction_startdate) {
		this.sanction_startdate = sanction_startdate;
	}
	public String getSanction_enddate() {
		return sanction_enddate;
	}
	public void setSanction_enddate(String sanction_enddate) {
		this.sanction_enddate = sanction_enddate;
	}
	
	@Override
	public String toString() {
		return "ReportHistoryDto [report_no=" + report_no + ", admin_no=" + admin_no + ", member_no=" + member_no
				+ ", sanction_category_no=" + sanction_category_no + ", sanction_startdate=" + sanction_startdate
				+ ", sanction_enddate=" + sanction_enddate + "]";
	}
}
