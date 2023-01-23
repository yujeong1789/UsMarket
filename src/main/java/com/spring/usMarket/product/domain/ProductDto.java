package com.spring.usMarket.product.domain;

import java.util.Date;

import com.spring.usMarket.common.TimeConvert;

public class ProductDto {
	private Integer member_state_no;
	private String product_no;
	private Integer seller_no;
	private Integer product_category1_no;
	private Integer product_category2_no;
	private Integer product_state_no;
	private String product_name;
	private String product_change; // Y - 교환, N - 교환불가
	private Integer product_price;
	private String product_explanation;
	private String product_tag;
	private Integer product_view;
	private Date product_regdate;
	private String product_pay_kind;
	private String product_used; // Y - 중고, N - 새상품
	private String product_img_uuid;
	
	
	
	public ProductDto() {
	}

	public ProductDto(Integer member_state_no, String product_no, Integer seller_no, Integer product_category1_no,
			Integer product_category2_no, Integer product_state_no, String product_name, String product_change,
			Integer product_price, String product_explanation, String product_tag, Integer product_view,
			Date product_regdate, String product_pay_kind, String product_used, String product_img_uuid) {
		
		this.member_state_no = member_state_no;
		this.product_no = product_no;
		this.seller_no = seller_no;
		this.product_category1_no = product_category1_no;
		this.product_category2_no = product_category2_no;
		this.product_state_no = product_state_no;
		this.product_name = product_name;
		this.product_change = product_change;
		this.product_price = product_price;
		this.product_explanation = product_explanation;
		this.product_tag = product_tag;
		this.product_view = product_view;
		this.product_regdate = product_regdate;
		this.product_pay_kind = product_pay_kind;
		this.product_used = product_used;
		this.product_img_uuid = product_img_uuid;
	}

	public Integer getMember_state_no() {
		return member_state_no;
	}

	public void setMember_state_no(Integer member_state_no) {
		this.member_state_no = member_state_no;
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

	public Integer getProduct_state_no() {
		return product_state_no;
	}

	public void setProduct_state_no(Integer product_state_no) {
		this.product_state_no = product_state_no;
	}

	public String getProduct_name() {
		return product_name;
	}

	public void setProduct_name(String product_name) {
		this.product_name = product_name;
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

	public Integer getProduct_view() {
		return product_view;
	}

	public void setProduct_view(Integer product_view) {
		this.product_view = product_view;
	}

	public String getProduct_regdate() {
		return TimeConvert.calculateTime(product_regdate);
	}

	public void setProduct_regdate(Date product_regdate) {
		this.product_regdate = product_regdate;
	}

	public String getProduct_pay_kind() {
		return product_pay_kind;
	}

	public void setProduct_pay_kind(String product_pay_kind) {
		this.product_pay_kind = product_pay_kind;
	}

	public String getProduct_used() {
		return product_used;
	}

	public void setProduct_used(String product_used) {
		this.product_used = product_used;
	}

	public String getProduct_img_uuid() {
		return product_img_uuid;
	}

	public void setProduct_img_uuid(String product_img_uuid) {
		this.product_img_uuid = product_img_uuid;
	}

	@Override
	public String toString() {
		return "ProductDto [member_state_no=" + member_state_no + ", product_no=" + product_no + ", seller_no="
				+ seller_no + ", product_category1_no=" + product_category1_no + ", product_category2_no="
				+ product_category2_no + ", product_state_no=" + product_state_no + ", product_name=" + product_name
				+ ", product_change=" + product_change + ", product_price=" + product_price + ", product_explanation="
				+ product_explanation + ", product_tag=" + product_tag + ", product_view=" + product_view
				+ ", product_regdate=" + getProduct_regdate() + ", product_pay_kind=" + product_pay_kind + ", product_used="
				+ product_used + ", product_img_uuid=" + product_img_uuid + "]";
	}
}
