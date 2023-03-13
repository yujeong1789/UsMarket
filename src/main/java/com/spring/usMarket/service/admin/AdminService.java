package com.spring.usMarket.service.admin;

import java.util.Map;

public interface AdminService {
	Map<String, Object> getAdmin(String admin_id, String admin_password) throws Exception;
}
