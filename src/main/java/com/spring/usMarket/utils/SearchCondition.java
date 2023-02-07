package com.spring.usMarket.utils;

import org.springframework.web.util.UriComponentsBuilder;

public class SearchCondition {
	private Integer page = 1;		// 기본값
	private Integer pageSize;		// 한 페이지당 출력될 상품 수
	private String option = "";		// 2 - 예약중, 3 - 판매 완료, 5 - 모두 포함
	private String keyword = "";	// 검색어
	private Integer category1;
	private Integer category2;
	
	public SearchCondition() {}
	
	public SearchCondition(Integer pageSize) {
		this.pageSize=pageSize;
	}
	
	public SearchCondition(Integer page, Integer pageSize, String option, String keyword, Integer category1, Integer category2) {
		this.page = page;
		this.pageSize = pageSize;
		this.option = option;
		this.keyword = keyword;
		this.category1 = category1;
		this.category2 = category2;
	}

	// 쿼리 스트링 생성
    public String getQueryString(Integer page, String option, String keyword, Integer category1, Integer category2){ // 쿼리 스트링 생성 위해 메서드 선언
    	// ?page=n&pageSize=n&option=n...
        return UriComponentsBuilder.newInstance()
                .queryParam("page", page)
                .queryParam("pageSize", pageSize)
                .queryParam("option", option)
                .queryParam("keyword", keyword)
                .queryParam("category1", category1)
                .queryParam("category2", category2)
                .build().toString();
    }
    
    // keyword, option값 존재할 때 카테고리 이동할 경우 페이지, option, keyword 초기화
    public String getQueryString(Integer category1, Integer category2){
    	return getQueryString(1, "", "", category1, category2);
    }
    
    // option값 새로 저장할 때 페이지 초기화 (keyword 유지)
    public String getQueryString(String option){
    	return getQueryString(1, option, keyword, category1, category2);
    }
    
    // 페이지 이동시 쿼리 스트링 유지하기 위한 메서드
    public String getQueryString(Integer page){
    	return getQueryString(page, option, keyword, category1, category2);
    }

    public String getQueryString(){
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

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	@Override
	public String toString() {
		return "SearchCondition [page=" + page + ", startPage=" + getStartPage() + ", endPage=" + getEndPage() + ", pageSize=" + pageSize + ", option=" + option + ", category1="
				+ category1 + ", keyword=" + keyword + ", category2=" + category2 + "]";
	}
}
