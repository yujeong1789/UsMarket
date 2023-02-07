package com.spring.usMarket.domain.product;

public class ProductInsertDto {
	private String product_no;
	private Integer seller_no;
	private Integer product_category1_no;
	private Integer product_category2_no;
	private String product_name;
	private String product_used;
	private String product_change;
	private Integer product_price;
	private String product_explanation;
	private String product_tag;
	
	public ProductInsertDto() {}

	public ProductInsertDto(String product_no, Integer seller_no, Integer product_category1_no,
			Integer product_category2_no, String product_name, String product_used, String product_change,
			Integer product_price, String product_explanation, String product_tag) {
		this.product_no = product_no;
		this.seller_no = seller_no;
		this.product_category1_no = product_category1_no;
		this.product_category2_no = product_category2_no;
		this.product_name = product_name;
		this.product_used = product_used;
		this.product_change = product_change;
		this.product_price = product_price;
		this.product_explanation = product_explanation;
		this.product_tag = product_tag;
	}

	public String getProduct_no() {
		return product_no;
	}

	public void setProduct_no(String product_no) {
		this.product_no = product_no;
	}

	public Integer getSeller_no() {
		return seller_no;
	}

	public void setSeller_no(Integer seller_no) {
		this.seller_no = seller_no;
	}

	public Integer getProduct_category1_no() {
		return product_category1_no;
	}

	public void setProduct_category1_no(Integer product_category1_no) {
		this.product_category1_no = product_category1_no;
	}

	public Integer getProduct_category2_no() {
		return product_category2_no;
	}

	public void setProduct_category2_no(Integer product_category2_no) {
		this.product_category2_no = product_category2_no;
	}

	public String getProduct_name() {
		return product_name;
	}

	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}

	public String getProduct_used() {
		return product_used;
	}

	public void setProduct_used(String product_used) {
		this.product_used = product_used;
	}

	public String getProduct_change() {
		return product_change;
	}

	public void setProduct_change(String product_change) {
		this.product_change = product_change;
	}

	public Integer getProduct_price() {
		return product_price;
	}

	public void setProduct_price(Integer product_price) {
		this.product_price = product_price;
	}

	public String getProduct_explanation() {
		return product_explanation;
	}

	public void setProduct_explanation(String product_explanation) {
		this.product_explanation = product_explanation;
	}

	public String getProduct_tag() {
		return product_tag;
	}

	public void setProduct_tag(String product_tag) {
		this.product_tag = product_tag;
	}

	@Override
	public String toString() {
		return "ProductInsertDto [product_no=" + product_no + ", seller_no=" + seller_no + ", product_category1_no="
				+ product_category1_no + ", product_category2_no=" + product_category2_no + ", product_name="
				+ product_name + ", product_used=" + product_used + ", product_change=" + product_change
				+ ", product_price=" + product_price + ", product_explanation=" + product_explanation + ", product_tag="
				+ product_tag + "]";
	}
}
