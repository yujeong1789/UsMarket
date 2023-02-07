package com.spring.usMarket.domain.deal;

import java.util.Date;

public class DealDto extends DealInsertDto{
	private String deal_review;			// 리뷰 작성 여부 Y/N
	private Date deal_complete_date;	// 거래종료일
	private String deal_delivery_state;	// 배송상태 (1-배송준비중, 2-배송중, 3-배송완료)
	private String deal_state;			// 거래상태 (1-거래진행중, 2-거래완료, 3-거래취소)
	
	public DealDto() {}
	
	public DealDto(String deal_no, String product_no, Integer seller_no, Integer customer_no,
			String customer_name, String customer_hp, String customer_zipcode, String customer_address,
			String dustomer_address_detail, String deal_delivery_message, 
			String deal_review, Date deal_complete_date, String deal_delivery_state, String deal_state) {
		
		super(deal_no, product_no, seller_no, customer_no, customer_name, customer_hp, customer_zipcode, customer_address, dustomer_address_detail, deal_delivery_message);
		
		this.deal_review = deal_review;
		this.deal_complete_date = deal_complete_date;
		this.deal_delivery_state = deal_delivery_state;
		this.deal_state = deal_state;
	}

	public String getDeal_review() {
		return deal_review;
	}

	public void setDeal_review(String deal_review) {
		this.deal_review = deal_review;
	}

	public Date getDeal_complete_date() {
		return deal_complete_date;
	}

	public void setDeal_complete_date(Date deal_complete_date) {
		this.deal_complete_date = deal_complete_date;
	}

	public String getDeal_delivery_state() {
		return deal_delivery_state;
	}

	public void setDeal_delivery_state(String deal_delivery_state) {
		this.deal_delivery_state = deal_delivery_state;
	}

	public String getDeal_state() {
		return deal_state;
	}

	public void setDeal_state(String deal_state) {
		this.deal_state = deal_state;
	}
	

	@Override
	public String toString() {
		return super.toString() + ", " + "DealDto [deal_review=" + deal_review + ", deal_complete_date=" + deal_complete_date
				+ ", deal_delivery_state=" + deal_delivery_state + ", deal_state=" + deal_state + "]";
	}
}
