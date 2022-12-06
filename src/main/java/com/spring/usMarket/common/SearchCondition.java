package com.spring.usMarket.common;


public class SearchCondition {
	private Integer page = 1; // 기본값
	private Integer pageSize; // 한 페이지당 출력될 상품 수
	
	public SearchCondition() {}
	
	public SearchCondition(Integer page, Integer pageSize) {
		this.page = page;
		this.pageSize = pageSize;
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

	@Override
	public String toString() {
		return "PageCondition [page=" + page + ", pageSize=" + pageSize + "]";
	}
	
}
