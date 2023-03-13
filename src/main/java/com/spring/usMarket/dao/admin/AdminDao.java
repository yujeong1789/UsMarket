package com.spring.usMarket.dao.admin;

import java.util.Map;

public interface AdminDao {
	Map<String, Object> searchAdmin(String admin_id, String admin_password) throws Exception;
}
