package com.spring.usMarket.utils;

public class NoticeSearchCondition {
	private Integer page = 1;
	private Integer pageSize;
	private String status = "";
	
	public NoticeSearchCondition() {}
	
	public NoticeSearchCondition(Integer pageSize) {
		this.pageSize = pageSize;
	}

	public NoticeSearchCondition(Integer page, Integer pageSize, String status) {
		this.page = page;
		this.pageSize = pageSize;
		this.status = status;
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

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@Override
	public String toString() {
		return "NoticeSearchCondition [page=" + page + ", startPage=" + getStartPage() + ", endPage=" + getEndPage() 
			+", pageSize=" + pageSize + ", status=" + status + "]";
	}
	
	
}
