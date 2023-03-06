package com.spring.usMarket.domain.report;

public class ReportInsertDto {
	private String report_no;
	private Integer member_no;
	private Integer report_member_no;
	private Integer report_category1_no;
	private Integer report_category2_no;
	private String report_content;
	private String report_image;
	private String report_info;
	
	public ReportInsertDto() {}
	
	public ReportInsertDto(String report_no, Integer member_no, Integer report_member_no, Integer report_category1_no,
			Integer report_category2_no, String report_content, String report_image, String report_info) {
		this.report_no = report_no;
		this.member_no = member_no;
		this.report_member_no = report_member_no;
		this.report_category1_no = report_category1_no;
		this.report_category2_no = report_category2_no;
		this.report_content = report_content;
		this.report_image = report_image;
		this.report_info = report_info;
	}
	
	public String getReport_no() {
		return report_no;
	}
	public void setReport_no(String report_no) {
		this.report_no = report_no;
	}
	public Integer getMember_no() {
		return member_no;
	}
	public void setMember_no(Integer member_no) {
		this.member_no = member_no;
	}
	public Integer getReport_member_no() {
		return report_member_no;
	}
	public void setReport_member_no(Integer report_member_no) {
		this.report_member_no = report_member_no;
	}
	public Integer getReport_category1_no() {
		return report_category1_no;
	}
	public void setReport_category1_no(Integer report_category1_no) {
		this.report_category1_no = report_category1_no;
	}
	public Integer getReport_category2_no() {
		return report_category2_no;
	}
	public void setReport_category2_no(Integer report_category2_no) {
		this.report_category2_no = report_category2_no;
	}
	public String getReport_content() {
		return report_content;
	}
	public void setReport_content(String report_content) {
		this.report_content = report_content;
	}
	public String getReport_image() {
		return report_image;
	}
	public void setReport_image(String report_image) {
		this.report_image = report_image;
	}
	public String getReport_info() {
		return report_info;
	}
	public void setReport_info(String report_info) {
		this.report_info = report_info;
	}
	
	@Override
	public String toString() {
		return "ReportInsertDto [report_no=" + report_no + ", member_no=" + member_no + ", report_member_no="
				+ report_member_no + ", report_category1_no=" + report_category1_no + ", report_category2_no="
				+ report_category2_no + ", report_content=" + report_content + ", report_image=" + report_image
				+ ", report_info=" + report_info + "]";
	}
}
