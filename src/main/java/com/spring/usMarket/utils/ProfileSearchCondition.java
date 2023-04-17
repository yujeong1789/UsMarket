package com.spring.usMarket.utils;

import java.text.SimpleDateFormat;
import java.util.Date;

public class ProfileSearchCondition {
	private Integer page = 1;
	private Integer pageSize;
	
	private String startDate = "2022-04-01";
	private String endDate = new SimpleDateFormat("yyyy-MM-dd").format(new Date()).toString();
	private String condition = "";
	private String order = "";
	private String member_no = "";
	private String complete = "";
	private String mode = "";
	
	public ProfileSearchCondition() {}

	public ProfileSearchCondition (Integer page, Integer pageSize, String startDate, String endDate, String condition,
			String order, String member_no, String complete, String mode) {
		this.page = page;
		this.pageSize = pageSize;
		this.startDate = startDate;
		this.endDate = endDate;
		this.condition = condition;
		this.order = order;
		this.member_no = member_no;
		this.complete = complete;
		this.mode = mode;
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

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getCondition() {
		return condition;
	}

	public void setCondition(String condition) {
		this.condition = condition;
	}

	public String getOrder() {
		return order;
	}

	public void setOrder(String order) {
		this.order = order;
	}

	public String getMember_no() {
		return member_no;
	}

	public void setMember_no(String member_no) {
		this.member_no = member_no;
	}

	public String getComplete() {
		return complete;
	}

	public void setComplete(String complete) {
		this.complete = complete;
	}

	public String getMode() {
		return mode;
	}
	
	public void setMode(String mode) {
		this.mode = mode;
	}
	
	@Override
	public String toString() {
		return "MypageSearchCondition [page=" + page + ", startPage=" + getStartPage() + ", endPage=" + getEndPage() + ", pageSize=" + pageSize + ", startDate=" + startDate
				+ ", endDate=" + endDate + ", condition=" + condition + ", order=" + order + ", member_no=" + member_no + ", complete=" + complete + ", mode=" + mode + "]";
	}
}
