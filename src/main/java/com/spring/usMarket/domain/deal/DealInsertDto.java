package com.spring.usMarket.domain.deal;

public class DealInsertDto {
	private String deal_no;					// 거래번호
	private String product_no;				// 상품번호
	private Integer seller_no;				// 판매회원 번호
	
	private Integer customer_no;			// 구매회원 번호
	private String customer_name;			// 구매회원 이름	
	private String customer_hp;				// 구매회원 연락처
	private String customer_zipcode;		// 우편번호
	private String customer_address;		// 주소
	private String customer_address_detail;	// 상세주소
	private String deal_delivery_message;	// 배송 메세지
	
	
	public DealInsertDto() {}


	public DealInsertDto(String deal_no, String product_no, Integer seller_no, Integer customer_no,
			String customer_name, String customer_hp, String customer_zipcode, String customer_address,
			String customer_address_detail, String deal_delivery_message) {
		this.deal_no = deal_no;
		this.product_no = product_no;
		this.seller_no = seller_no;
		this.customer_no = customer_no;
		this.customer_name = customer_name;
		this.customer_hp = customer_hp;
		this.customer_zipcode = customer_zipcode;
		this.customer_address = customer_address;
		this.customer_address_detail = customer_address_detail;
		this.deal_delivery_message = deal_delivery_message;
	}


	public String getDeal_no() {
		return deal_no;
	}


	public void setDeal_no(String deal_no) {
		this.deal_no = deal_no;
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


	public Integer getCustomer_no() {
		return customer_no;
	}


	public void setCustomer_no(Integer customer_no) {
		this.customer_no = customer_no;
	}


	public String getCustomer_name() {
		return customer_name;
	}


	public void setCustomer_name(String customer_name) {
		this.customer_name = customer_name;
	}


	public String getCustomer_hp() {
		return customer_hp;
	}


	public void setCustomer_hp(String customer_hp) {
		this.customer_hp = customer_hp;
	}


	public String getCustomer_zipcode() {
		return customer_zipcode;
	}


	public void setCustomer_zipcode(String customer_zipcode) {
		this.customer_zipcode = customer_zipcode;
	}


	public String getCustomer_address() {
		return customer_address;
	}


	public void setCustomer_address(String customer_address) {
		this.customer_address = customer_address;
	}


	public String getCustomer_address_detail() {
		return customer_address_detail;
	}


	public void setCustomer_address_detail(String customer_address_detail) {
		this.customer_address_detail = customer_address_detail;
	}


	public String getDeal_delivery_message() {
		return deal_delivery_message;
	}


	public void setDeal_delivery_message(String deal_delivery_message) {
		this.deal_delivery_message = deal_delivery_message;
	}


	@Override
	public String toString() {
		return "DealInsertDto [deal_no=" + deal_no + ", product_no=" + product_no + ", seller_no=" + seller_no
				+ ", customer_no=" + customer_no + ", customer_name=" + customer_name + ", customer_hp=" + customer_hp
				+ ", customer_zipcode=" + customer_zipcode + ", customer_address=" + customer_address
				+ ", customer_address_detail=" + customer_address_detail + ", deal_delivery_message="
				+ deal_delivery_message + "]";
	}
}
