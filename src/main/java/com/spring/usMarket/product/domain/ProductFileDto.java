package com.spring.usMarket.product.domain;

public class ProductFileDto {
	private String product_no;
	private String product_img_path;
	private String product_img_filename;
	private String product_img_uuid;
	private Integer product_img_order;
	
	public ProductFileDto() {}
	
	public ProductFileDto(String product_no, String product_img_path, String product_img_filename,
			String product_img_uuid, Integer product_img_order) {
		this.product_no = product_no;
		this.product_img_path = product_img_path;
		this.product_img_filename = product_img_filename;
		this.product_img_uuid = product_img_uuid;
		this.product_img_order = product_img_order;
	}

	public String getProduct_no() {
		return product_no;
	}

	public void setProduct_no(String product_no) {
		this.product_no = product_no;
	}

	public String getProduct_img_path() {
		return product_img_path;
	}

	public void setProduct_img_path(String product_img_path) {
		this.product_img_path = product_img_path;
	}

	public String getProduct_img_filename() {
		return product_img_filename;
	}

	public void setProduct_img_filename(String product_img_filename) {
		this.product_img_filename = product_img_filename;
	}

	public String getProduct_img_uuid() {
		return product_img_uuid;
	}

	public void setProduct_img_uuid(String product_img_uuid) {
		this.product_img_uuid = product_img_uuid;
	}

	public Integer getProduct_img_order() {
		return product_img_order;
	}

	public void setProduct_img_order(Integer product_img_order) {
		this.product_img_order = product_img_order;
	}

	@Override
	public String toString() {
		return "ProductFileDto [product_no=" + product_no + ", product_img_path=" + product_img_path
				+ ", product_img_filename=" + product_img_filename + ", product_img_uuid=" + product_img_uuid
				+ ", product_img_order=" + product_img_order + "]";
	}
}
