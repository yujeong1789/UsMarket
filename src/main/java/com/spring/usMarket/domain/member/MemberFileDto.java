package com.spring.usMarket.domain.member;

public class MemberFileDto {
	private Integer member_no;
	private String member_img_path;
	private String member_img_filename;
	private String member_img_uuid;

	public MemberFileDto() {}

	public MemberFileDto(Integer member_no, String member_img_path, String member_img_filename,
			String member_img_uuid) {
		super();
		this.member_no = member_no;
		this.member_img_path = member_img_path;
		this.member_img_filename = member_img_filename;
		this.member_img_uuid = member_img_uuid;
	}
	
	public Integer getMember_no() {
		return member_no;
	}
	public void setMember_no(Integer member_no) {
		this.member_no = member_no;
	}
	public String getMember_img_path() {
		return member_img_path;
	}
	public void setMember_img_path(String member_img_path) {
		this.member_img_path = member_img_path;
	}
	public String getMember_img_filename() {
		return member_img_filename;
	}
	public void setMember_img_filename(String member_img_filename) {
		this.member_img_filename = member_img_filename;
	}
	public String getMember_img_uuid() {
		return member_img_uuid;
	}
	public void setMember_img_uuid(String member_img_uuid) {
		this.member_img_uuid = member_img_uuid;
	}
	
	@Override
	public String toString() {
		return "MemberFileDto [member_no=" + member_no + ", member_img_path=" + member_img_path
				+ ", member_img_filename=" + member_img_filename + ", member_img_uuid=" + member_img_uuid + "]";
	}
	
}
