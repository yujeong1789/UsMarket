package com.spring.usMarket.exception;

import com.spring.usMarket.domain.member.MemberDto;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class MemberExistsException extends Exception {
	private static final long serialVersionUID = 1L;

	//예외처리에 필요한 값을 저장하기 위한 필드
	// => 사용자가 입력한 회원정보를 저장하기 위한 필드
	private MemberDto member;

	public MemberExistsException() {
		// TODO Auto-generated constructor stub
	}

	public MemberExistsException(String message, MemberDto member) {
		super(message);
		this.member = member;
	}




}