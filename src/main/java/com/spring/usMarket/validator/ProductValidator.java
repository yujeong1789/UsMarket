package com.spring.usMarket.validator;

import org.springframework.validation.Errors;
import org.springframework.validation.Validator;

import com.spring.usMarket.utils.SearchCondition;

public class ProductValidator implements Validator{

	@Override
	public boolean supports(Class<?> clazz) {
		return SearchCondition.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
		System.out.println("validator is called");
		
		SearchCondition sc = (SearchCondition)target;
		
		if(sc.getKeyword().length()<2) {
			errors.rejectValue("keyword", "검색어는 두 글자 이상 입력해 주세요.");
		}
		
	}
	

}
