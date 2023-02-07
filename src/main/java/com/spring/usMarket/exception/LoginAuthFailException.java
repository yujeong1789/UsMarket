package com.spring.usMarket.exception;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class LoginAuthFailException extends Exception {
	private static final long serialVersionUID = 1L;

	//사용자가 입력한 아이디를 저장하기 위한 필드
	private String id;

	public LoginAuthFailException() {
		// TODO Auto-generated constructor stub
	}


	public LoginAuthFailException(String message, String id) {
		super(message);
		this.id = id;
	}
}