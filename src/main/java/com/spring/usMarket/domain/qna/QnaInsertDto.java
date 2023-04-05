package com.spring.usMarket.domain.qna;

public class QnaInsertDto {
	private String qna_no;				// 문의번호
	private Integer member_no = 0;			// 접수회원번호
	private Integer qna_category1_no;	// 문의 대분류 번호
	private String qna_title;			// 제목
	private String qna_image = "";		// 이미지
	private String qna_content;			// 내용
	
	public QnaInsertDto() {}
	
	public QnaInsertDto(String qna_no, Integer member_no, Integer qna_category1_no, String qna_title, String qna_image,
			String qna_content) {
		this.qna_no = qna_no;
		this.member_no = member_no;
		this.qna_category1_no = qna_category1_no;
		this.qna_title = qna_title;
		this.qna_image = qna_image;
		this.qna_content = qna_content;
	}

	public String getQna_no() {
		return qna_no;
	}

	public void setQna_no(String qna_no) {
		this.qna_no = qna_no;
	}

	public Integer getMember_no() {
		return member_no;
	}

	public void setMember_no(Integer member_no) {
		this.member_no = member_no;
	}

	public Integer getQna_category1_no() {
		return qna_category1_no;
	}

	public void setQna_category1_no(Integer qna_category1_no) {
		this.qna_category1_no = qna_category1_no;
	}

	public String getQna_title() {
		return qna_title;
	}

	public void setQna_title(String qna_title) {
		this.qna_title = qna_title;
	}

	public String getQna_image() {
		return qna_image;
	}

	public void setQna_image(String qna_image) {
		this.qna_image = qna_image;
	}

	public String getQna_content() {
		return qna_content;
	}

	public void setQna_content(String qna_content) {
		this.qna_content = qna_content;
	}

	@Override
	public String toString() {
		return "QnaInsertDto [qna_no=" + qna_no + ", member_no=" + member_no + ", qna_category1_no=" + qna_category1_no
				+ ", qna_title=" + qna_title + ", qna_image=" + qna_image + ", qna_content=" + qna_content + "]";
	}
}
