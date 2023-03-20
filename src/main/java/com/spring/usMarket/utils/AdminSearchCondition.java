package com.spring.usMarket.utils;

public class AdminSearchCondition {
	private String startDate;
	private String endDate;
	private String condition;
	
	public AdminSearchCondition() {}
	
	public AdminSearchCondition(String startDate, String endDate, String condition) {
		this.startDate = startDate;
		this.endDate = endDate;
		this.condition = condition;
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

	@Override
	public String toString() {
		return "AdminSearchCondition [startDate=" + startDate + ", endDate=" + endDate + ", condition=" + condition
				+ "]";
	}
	
}
