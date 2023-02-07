package com.spring.usMarket.exception;

//회원정보의 변경,삭제,검색시 아이디의 회원정보가 없는 경우에 대한 예외처리를 위해 작성된 예외클래스 
public class MemberNotFoundException extends Exception {
	private static final long serialVersionUID = 1L;

	public MemberNotFoundException() {
		// TODO Auto-generated constructor stub
	}
	
	public MemberNotFoundException(String message) {
		super(message);
	}
}