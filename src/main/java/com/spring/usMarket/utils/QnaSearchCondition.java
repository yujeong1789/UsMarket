package com.spring.usMarket.utils;

public class QnaSearchCondition {
	private Integer page = 1;
	private Integer pageSize;
	private String member_no = "";
	
	public QnaSearchCondition() {}

	public QnaSearchCondition(Integer page, Integer pageSize, String member_no) {
		this.page = page;
		this.pageSize = pageSize;
		this.member_no = member_no;
	}
	
	public Integer getStartPage() {
		return 1+(page-1)*pageSize; // 1, 31, 61...
	}
	
	public Integer getEndPage() {
		return page*pageSize; // 30, 60, 90...
	}

	public Integer getPage() {
		return page;
	}

	public void setPage(Integer page) {
		this.page = page;
	}

	public Integer getPageSize() {
		return pageSize;
	}

	public void setPageSize(Integer pageSize) {
		this.pageSize = pageSize;
	}

	public String getMember_no() {
		return member_no;
	}

	public void setMember_no(String member_no) {
		this.member_no = member_no;
	}

	@Override
	public String toString() {
		return "QnaSearchCondition [page=" + page + ", startPage=" + getStartPage() + ", endPage=" + getEndPage() 
				+ ", pageSize=" + pageSize + ", member_no=" + member_no + "]";
	}
	
	
	
	
}
