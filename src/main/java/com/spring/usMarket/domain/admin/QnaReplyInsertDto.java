package com.spring.usMarket.domain.admin;

public class QnaReplyInsertDto {
	private String qna_no;
	private String admin_no;
	private String qna_reply_content;

	public QnaReplyInsertDto() {}
	
	public QnaReplyInsertDto(String qna_no, String admin_no, String qna_reply_content) {
		this.qna_no = qna_no;
		this.admin_no = admin_no;
		this.qna_reply_content = qna_reply_content;
	}

	public String getQna_no() {
		return qna_no;
	}

	public void setQna_no(String qna_no) {
		this.qna_no = qna_no;
	}

	public String getAdmin_no() {
		return admin_no;
	}

	public void setAdmin_no(String admin_no) {
		this.admin_no = admin_no;
	}

	public String getQna_reply_content() {
		return qna_reply_content;
	}

	public void setQna_reply_content(String qna_reply_content) {
		this.qna_reply_content = qna_reply_content;
	}

	@Override
	public String toString() {
		return "QnaReplyInsertDto [qna_no=" + qna_no + ", admin_no=" + admin_no + ", qna_reply_content="
				+ qna_reply_content + "]";
	}
}
