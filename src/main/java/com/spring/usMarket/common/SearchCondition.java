package com.spring.usMarket.common;

import org.springframework.web.util.UriComponentsBuilder;

public class SearchCondition {
	private Integer page = 1; // 기본값
	private Integer pageSize; // 한 페이지당 출력될 상품 수
	private String option = "";
	private Integer category1;
	private Integer category2;
	
	public SearchCondition() {}
	
	public SearchCondition(Integer pageSize) {
		this.pageSize=pageSize;
	}
	
	public SearchCondition(Integer page, Integer pageSize, String option, Integer category1, Integer category2) {
		this.page = page;
		this.pageSize = pageSize;
		this.option = option;
		this.category1 = category1;
		this.category2 = category2;
	}

    public String getQueryString(Integer page){ // 쿼리 스트링 생성 위해 메서드 선언
        return UriComponentsBuilder.newInstance()
                .queryParam("page", page)
                .queryParam("pageSize", pageSize)
                .queryParam("option", option)
                .queryParam("category1", category1)
                .queryParam("category2", category2)
                .build().toString();
    }

    public String getQueryString(){ // 쿼리 스트링 유지 위해 메서드 선언
        // ?page=n&pageSize=n&option=n&keyword=n
        return getQueryString(page);
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

	public String getOption() {
		return option;
	}

	public void setOption(String option) {
		this.option = option;
	}

	public Integer getCategory1() {
		return category1;
	}

	public void setCategory1(Integer category1) {
		this.category1 = category1;
	}

	public Integer getCategory2() {
		return category2;
	}

	public void setCategory2(Integer category2) {
		this.category2 = category2;
	}

	@Override
	public String toString() {
		return "SearchCondition [page=" + page + ", startPage=" + getStartPage() + ", endPage=" + getEndPage() + ", pageSize=" + pageSize + ", option=" + option + ", category1="
				+ category1 + ", category2=" + category2 + "]";
	}
}
