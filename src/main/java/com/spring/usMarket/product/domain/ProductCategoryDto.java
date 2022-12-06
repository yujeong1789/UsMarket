package com.spring.usMarket.product.domain;


public class ProductCategoryDto {
	private Integer product_category1_no;
	private String product_category1_name;
	private Integer product_category2_no;
	private String product_category2_name;
	
	public ProductCategoryDto() {}

	public ProductCategoryDto(Integer product_category1_no, String product_category1_name, Integer product_category2_no,
			String product_category2_name) {
		this.product_category1_no = product_category1_no;
		this.product_category1_name = product_category1_name;
		this.product_category2_no = product_category2_no;
		this.product_category2_name = product_category2_name;
	}

	public Integer getProduct_category1_no() {
		return product_category1_no;
	}



	public void setProduct_category1_no(Integer product_category1_no) {
		this.product_category1_no = product_category1_no;
	}



	public String getProduct_category1_name() {
		return product_category1_name;
	}



	public void setProduct_category1_name(String product_category1_name) {
		this.product_category1_name = product_category1_name;
	}

	public Integer getProduct_category2_no() {
		return product_category2_no;
	}

	public void setProduct_category2_no(Integer product_category2_no) {
		this.product_category2_no = product_category2_no;
	}

	public String getProduct_category2_name() {
		return product_category2_name;
	}

	public void setProduct_category2_name(String product_category2_name) {
		this.product_category2_name = product_category2_name;
	}

	@Override
	public String toString() {
		return "ProductCategoryDto [product_category1_no=" + product_category1_no + ", product_category1_name="
				+ product_category1_name + ", product_category2_no=" + product_category2_no
				+ ", product_category2_name=" + product_category2_name + "]";
	}
}
