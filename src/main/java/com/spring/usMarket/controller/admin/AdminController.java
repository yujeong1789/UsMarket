package com.spring.usMarket.controller.admin;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.spring.usMarket.service.admin.AdminService;

@Controller
@RequestMapping("/admin")
public class AdminController { // 관리자 메인 페이지 출력
	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
	
	@Autowired AdminService adminService;
	
	@GetMapping("/home")
	public void main(Model model) {
		logger.info("admin home");
		
		List<Map<String, Object>> qnaMap = new ArrayList<>();
		List<Map<String, Object>> reportMap = new ArrayList<>();
		try {
			qnaMap = adminService.getQnaList("1", "5"); 
			reportMap = adminService.getReportList("1", "5");
			
			model.addAttribute("qnaMap", qnaMap);
			model.addAttribute("reportMap", reportMap);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	@GetMapping("/login")
	public void login(HttpServletRequest request, Model model){
		logger.info("admin login");
	}
	
	@PostMapping("/login")
	public String loginCheck(HttpServletRequest request, String admin_id, String admin_password, Model model, RedirectAttributes ratt){
		
		logger.info("admin_id = {}, admin_password = {}", admin_id, admin_password);
		
		Map<String, Object> adminMap = new HashMap<>();
		try {
			adminMap = adminService.getAdmin(admin_id, admin_password);
			
			if(adminMap == null) {
				ratt.addFlashAttribute("message", "false");
				ratt.addFlashAttribute("admin_id", admin_id);
				logger.info("로그인 실패");
				return "redirect:/admin/login";
			}
			
			logger.info("로그인 성공");
			HttpSession session = request.getSession();
			session.setAttribute("admin", adminMap);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/admin/home";
	}
	
	@GetMapping("/logout")
	public String logout(HttpServletRequest request) {
		
		request.getSession().removeAttribute("admin");;
		logger.info("로그아웃 {}", (request.getSession().getAttribute("admin") == null ? "성공" : "실패"));
		
		return "redirect:/admin/home";
	}	

}
