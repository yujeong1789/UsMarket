package com.spring.usMarket.product.domain;

import com.spring.usMarket.common.SearchCondition;

public class ProductPageHandler extends SearchCondition{
	private Integer category1;
	private Integer category2;
	private String option;
	
	public ProductPageHandler() {
		super(1, 30);
	}
	
	public ProductPageHandler(Integer page, Integer category1, Integer category2, String option) {
		super(page, 30); // page, paseSize
		this.category1 = category1;
		this.category2 = category2;
		this.option = option;
	}

	public Integer getStartPage() {
		return 1-(super.getPage()-1)*super.getPageSize(); // 1, 31, 61...
	}
	
	public Integer getEndpage() {
		return super.getPage()*super.getPageSize(); // 30, 60, 90...
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

	public String getOption() {
		return option;
	}

	public void setOption(String option) {
		this.option = option;
	}

	@Override
	public String toString() {
		return "ProductSearchCondition ["+super.toString()+", category1=" + category1 + ", category2=" + category2 + ", option=" + option
				+ "]";
	}
}
