package doto.ctrl.admin;

import java.io.PrintWriter;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import doto.svc.admin.AdminService;

@Controller
@RequestMapping(value = "/admin")
public class AdminController {
Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="adminService")
	private AdminService adminService;
	
	/*
	 * 어드민 인덱스(홈) 화면
	 */
	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public String index() throws Exception {

		return "admin/index";

	}
	
	/*
	 * 어드민 로그인 화면
	 */
	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String adminLogin() throws Exception {
		return "admin/loginform";
	}
	
	
	/*
	 * 어드민 로그인 Act
	 */
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public void adminLoginAct(@RequestParam Map<String,Object> map, ModelMap model, HttpServletResponse response, HttpServletRequest request) throws Exception {
		PrintWriter out = response.getWriter();
		
		boolean adminLoginOk = adminService.isAdminLoginOk(map, response, request);
		
		//ajax 처리
		out.print(adminLoginOk); //이 값이 rData로 넘어감
		out.flush();
		out.close();
		
	}
	
	/*
	 * 패널티 상품 list(다 건) 조회
	 */
	@RequestMapping(value = "/penalty", method = RequestMethod.GET)
	public String readPenaltyList(ModelMap model) throws Exception {

		List<Map<String,Object>> penaltyList = adminService.selectPenaltyList();
		
		model.addAttribute("list", penaltyList);
		
		return "admin/penalty/penalties";

	}
	
	/*
	 * 어드민 패널티상품 등록하기 폼
	 */
	@RequestMapping(value = "/penalty", method = RequestMethod.POST)
	public void createPenaltyAct(@RequestParam Map<String,Object> map, ModelMap model, HttpServletResponse response, HttpSession session) throws Exception {
		PrintWriter out = response.getWriter();
		
		boolean insertPenaltyOk = adminService.insertPenalty(map);
		
		//ajax 처리
		out.print(insertPenaltyOk); //이 값이 rData로 넘어감
		out.flush();
		out.close();

	}
	
	/*
	 * 공지사항 list(다 건) 조회
	 */
	@RequestMapping(value = "/notices", method = RequestMethod.GET)
	public String readNoticeList(ModelMap model) throws Exception {

		List<Map<String,Object>> noticeList = adminService.selectNoticeList();
		
		model.addAttribute("list", noticeList);
		
		return "admin/notice/notices";

	}
	
	/*
	 * 목표 등록하기 폼
	 */
	@RequestMapping(value = "/noticesform", method = RequestMethod.GET)
	public String createGoalForm(Map<String,Object> map, ModelMap model, HttpSession session) throws Exception {
		
		return "admin/notice/noticesform";

	}
	
	/*
	 * 목표 등록 act
	 */
	@RequestMapping(value = "/notices", method = RequestMethod.POST)
	public String createGoalAct(@RequestParam Map<String,Object> map) throws Exception {
		
		adminService.insertNotice(map);
		
		return "redirect:/admin/notices";

	}
	
}
