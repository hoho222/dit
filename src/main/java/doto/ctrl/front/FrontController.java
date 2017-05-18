package doto.ctrl.front;

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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import doto.svc.front.FrontService;

@Controller
public class FrontController {
	Logger log = Logger.getLogger(this.getClass());
	
	@Resource(name="frontService")
	private FrontService frontService;
	
	/*
	 * 인덱스(홈) 화면
	 */
	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public String index() throws Exception {

		return "front/index";

	}
	
	/*
	 * 공지사항 list(다 건) 조회
	 */
	@RequestMapping(value = "/notices", method = RequestMethod.GET)
	public String readNoticeList(ModelMap model) throws Exception {

		List<Map<String,Object>> noticeList = frontService.selectNoticeList();
		
		model.addAttribute("list", noticeList);
		
		return "front/notice/notices";

	}
	
	/*
	 * 공지사항 상세(1 건) 조회
	 */
	@RequestMapping(value = "/notices/{idx}", method = RequestMethod.GET)
	public String readNotice(@PathVariable String idx, ModelMap model) throws Exception {
		
		//조회수 먼저 증가
		frontService.updateNoticeHitCnt(idx);
		
		//해당 글 내용 select
		Map<String,Object> noticeMap = frontService.selectNoticeDetail(idx);
		model.addAttribute("noticeMap", noticeMap);
		model.addAttribute("idx", idx);
		
		return "front/notice/notices_detail";

	}
	
	
	
	/*
	 * 로그인 폼
	 */
	@RequestMapping(value = "/users/login", method = RequestMethod.GET)
	public String login(ModelMap model) throws Exception {
		
		return "front/user/loginform";

	}
	
	/*
	 * 두투 로그인 Act
	 */
	@RequestMapping(value = "/users/login", method = RequestMethod.POST)
	public void loginAct(@RequestParam Map<String,Object> map, ModelMap model, HttpServletResponse response, HttpServletRequest request) throws Exception {
		
		PrintWriter out = response.getWriter();
		
		boolean loginOk = frontService.isLoginOk(map, response, request);
		
		//ajax 처리
		out.print(loginOk); //이 값이 rData로 넘어감
		out.flush();
		out.close();
		
	}
	
	
	/*
	 * 로그아웃
	 */
	@RequestMapping(value="/users/logout", method = RequestMethod.GET)
	public String logout(HttpServletRequest request) throws Exception {
		HttpSession session = request.getSession();
		session.invalidate();
		
		return "redirect:login";
	}
	
	/*
	 * 마이페이지 회원정보 조회
	 */
	@RequestMapping(value = "/mypages/{idx}", method = RequestMethod.GET)
	public String readMypageInfo(@PathVariable String idx, ModelMap model, HttpSession session) throws Exception {
		
		Map<String,Object> memberMap = frontService.selectMemberDetail2(idx);
		model.addAttribute("memberMap", memberMap);
		
		return "front/mypage/memberinfo";

	}
	
	/*
	 * 마이페이지 회원정보 수정 ( -> 원래는 닉네임도 바꿀 수 있게 했었는데, 닉넴 바꾸면 세션 다시 초기화 해야될 것 같아서 일단 비번만 바꾸게 함)
	 */
	@RequestMapping(value = "/mypages/change", method = RequestMethod.POST)
	public String updateMypageInfo(@RequestParam Map<String,Object> map, ModelMap model) throws Exception {
		
		boolean isOk = frontService.updateMemberInfo(map);
		
		if(!isOk){
			model.addAttribute("msg", "현재 비밀번호가 올바르지 않습니다. 올바르게 입력해주세요."); 
		} else {
			model.addAttribute("msg", "비밀번호 변경 성공!"); 
		}
		model.addAttribute("url", "/doto/mypages/"+map.get("idx").toString()); 
		
		return "front/mypage/memberinfoAct";

	}
	
	
	/*
	 * 마이페이지 목표들list(다 건) 조회
	 */
	@RequestMapping(value = "/mypages/goals", method = RequestMethod.GET)
	public String readGoalListMypage(@RequestParam Map<String,Object> map, ModelMap model, HttpSession session) throws Exception {
		
		map.put("pageGB", "mypages");
		map.put("loginIdx", session.getAttribute("loginIdx"));
		
		List<Map<String,Object>> goalList = frontService.selectGoalList(map);
		
		model.addAttribute("goalList", goalList);
		
		return "front/mypage/goals_finish";

	}
	
	/*
	 * 마이페이지 -> 지난목표 상세(1 건) 조회
	 */
	@RequestMapping(value = "/mypages/goals/{idx}", method = RequestMethod.GET)
	public String readGoalDetailMypage(@PathVariable String idx, ModelMap model) throws Exception {
		
		//해당 글 내용 select
		Map<String,Object> goalMap = frontService.selectGoalDetail(idx);
		model.addAttribute("goalMap", goalMap);
		model.addAttribute("idx", idx);
		
		//해당글의 소감 + 업로드 했던 이미지 select
		Map<String,Object> resultMap = frontService.selectGoalResult(idx);
		model.addAttribute("resultMap", resultMap);
		
		return "front/mypage/goals_finish_detail";

	}
	
	/*
	 * 목표달성 list(다 건) 조회
	 */
	@RequestMapping(value = "/goals", method = RequestMethod.GET)
	public String readGoalList(@RequestParam Map<String,Object> map, ModelMap model, HttpSession session) throws Exception {
		
		map.put("pageGB", "goals");
		map.put("loginIdx", session.getAttribute("loginIdx"));
		
		List<Map<String,Object>> goalList = frontService.selectGoalList(map);
		
		model.addAttribute("goalList", goalList);
		
		return "front/goal/goals";

	}
	
	/*
	 * 목표달성 상세(1 건) 조회
	 */
	@RequestMapping(value = "/goals/{idx}", method = RequestMethod.GET)
	public String readGoalDetail(@PathVariable String idx, ModelMap model) throws Exception {
		
		//해당 글 내용 select
		Map<String,Object> goalMap = frontService.selectGoalDetail(idx);
		model.addAttribute("goalMap", goalMap);
		model.addAttribute("idx", idx);
		
		//해당글의 코멘트 + 업로드 했던 이미지 select
		List<Map<String,Object>> goalCommentList = frontService.selectGoalCommentList(idx);
		model.addAttribute("goalCommentList", goalCommentList);
		
		return "front/goal/goals_detail";

	}
	
	/*
	 * 목표 등록하기 폼
	 */
	@RequestMapping(value = "/goalsform", method = RequestMethod.GET)
	public String createGoalForm(Map<String,Object> map, ModelMap model, HttpSession session) throws Exception {
		
		//두투 회원인 경우, 이메일만 조사하면 SNS계정의 이메일과 중복될 수 있으므로, 이름과 닉네임까지 받아서 넘김
		if(session.getAttribute("loginFbId") == null && session.getAttribute("loginKakaoId") == null){
			map.put("emailId", session.getAttribute("loginId"));
			map.put("loginName", session.getAttribute("loginName"));
			map.put("loginNickName", session.getAttribute("loginNickName"));
		}
		
		//페이스북 로그인 회원인 경우 페이스북 숫자Id만 넘김
		if(session.getAttribute("loginFbId") != null){
			map.put("fbId", session.getAttribute("loginFbId"));
		}
		
		//카카오톡 로그인 회원인 경우 카카오톡 숫자Id만 넘김
		if(session.getAttribute("loginKakaoId") != null){
			map.put("kakaoId", session.getAttribute("loginKakaoId"));
		}
		
		Map<String,Object> memberMap = frontService.selectMemberDetail(map);
		model.addAttribute("loginNo", memberMap.get("IDX"));
		
		return "front/goal/goalsform";

	}
	
	/*
	 * 목표 등록 act
	 */
	@RequestMapping(value = "/goals", method = RequestMethod.POST)
	public String createGoalAct(@RequestParam Map<String,Object> map) throws Exception {
		
		frontService.insertGoal(map);
		
		return "redirect:goals";

	}
	
	/*
	 * 목표상세에서 코멘트 등록 act
	 */
	@RequestMapping(value = "/goals/comments", method = RequestMethod.POST)
	public String createGoalCommentAct(@RequestParam Map<String,Object> map, HttpServletRequest request) throws Exception {

		frontService.insertGoalComment(map, request);
		
		return "redirect:/goals/"+map.get("goalIdx").toString();

	}
	
	/*
	 * 목표상세에서 코멘트 수정/삭제 act
	 */
	@RequestMapping(value = "/goals/comments_action", method = RequestMethod.POST)
	public String processGoalCommentAct(@RequestParam Map<String,Object> map, HttpServletRequest request) throws Exception {
		
		frontService.processGoalCommentAct(map, request);
		
		return "redirect:/goals/"+map.get("goalIdx").toString();

	}
	
	/*
	 * 목표 성공/실패 소감 등록 act
	 */
	@RequestMapping(value = "/goals/results", method = RequestMethod.POST)
	public String createGoalResultAct(@RequestParam Map<String,Object> map, HttpServletRequest request) throws Exception {
		
		//성공/실패여부 먼저 T_GOAL 에 update
		frontService.updateGoal(map);
		
		//성공/실패 소감 T_GOAL_RESULT 에 insert + 목표 확인자가 '타인' 일 경우, 메일전송
		frontService.insertGoalResult(map, request);
		
		return "redirect:/goals";

	}
	
	/*
	 * 목표상세 -> 주기 1 cnt up
	 */
	@RequestMapping(value = "/goals/update_goal_period_hit", method = RequestMethod.POST)
	public void updateGoalPeriodHit(@RequestParam Map<String,Object> map, HttpServletResponse response) throws Exception {
		
		PrintWriter out = response.getWriter();
		
		//주기 1 cnt up
		boolean isOk = frontService.updateGoalPeriodHit(map);
		
		out.print(isOk); //이 값이 rData로 넘어감
		out.flush();
		out.close();
		
	}
	
	/*
	 * 회원가입 폼
	 */
	@RequestMapping(value = "/users/joinform", method = RequestMethod.GET)
	public String createJoinForm(ModelMap model) throws Exception {
		
		return "front/user/joinform";

	}
	
	/*
	 * 회원 등록 act
	 */
	@RequestMapping(value = "/users/join", method = RequestMethod.POST)
	public String createMemberAct(@RequestParam Map<String,Object> map, HttpServletResponse response, HttpServletRequest request) throws Exception {
		
		//fbJoin 키가 map안에 존재하는지 여부에 따라 분기(페이스북으로 가입).
		if(map.containsKey("fbJoin")){
			
			PrintWriter out = response.getWriter();
			
			boolean isFirstFbLogin = false;
			
			if("OK".equals(map.get("fbJoin"))){
				//만약 페이스북 이메일이 없을경우(ex: 애초에 페이스북 가입을 휴대폰번호로 한 경우)는 fbEmailId값이 'undefined'로 나옴

				//페이스북으로 가입
				
				isFirstFbLogin = frontService.insertMemberFb(map, request);
				
			}
			
			//ajax 처리
			out.print(isFirstFbLogin); //이 값이 rData로 넘어감
			out.flush();
			out.close();
			return "redirect:login";
		} 
		//kakaoJoin 키가 map안에 존재하는지 여부에 따라분기(카카오톡으로 가입).
		else if(map.containsKey("kakaoJoin")){
			
			PrintWriter out = response.getWriter();
			
			boolean isFirstKakaoLogin = false;
			
			if("OK".equals(map.get("kakaoJoin"))){
				//카카오톡으로 가입
				isFirstKakaoLogin = frontService.insertMemberKakao(map, request);
				
			}
			
			//ajax 처리
			out.print(isFirstKakaoLogin); //이 값이 rData로 넘어감
			out.flush();
			out.close();
			return "redirect:login";
		} else {
			//두잇투게더로 가입
			frontService.insertMember(map);
			return "redirect:login";
		}
		

	}
	
	/*
	 * 회원 가입시 이메일 중복확인
	 */
	@RequestMapping(value = "/users/joinoverlap", method = RequestMethod.POST)
	public void readEmailOverlap(@RequestParam Map<String,Object> map, HttpServletResponse response) throws Exception {
		
		PrintWriter out = response.getWriter();
		
		boolean isOverlap = frontService.memberOverlap(map);
		
		//ajax 처리
		out.print(isOverlap); //이 값이 rData로 넘어감
		out.flush();
		out.close();

	}
	
	/*
	 * 회원 가입시 이메일 인증
	 */
	@RequestMapping(value = "/users/joinauth", method = RequestMethod.POST)
	public String createMemberAuth(@RequestParam Map<String,Object> map, ModelMap model, HttpServletRequest request) throws Exception {
		
		frontService.memberAuth(map, request);
		
		return "front/user/joinauth";

	}
	
	/*
	 * 회원 가입시 이메일 인증 act
	 */
	@RequestMapping(value = "/users/joinauth/result", method = RequestMethod.POST)
	public String createMemberAuthAct(@RequestParam Map<String,Object> map, ModelMap model, HttpSession session) throws Exception {
		
		boolean authOk = frontService.memberAuthAct(map, session);
		
		//유저가 입력한 인증키와 세션에 저장된 인증키의 일치여부를 판단
		if(authOk) {
			model.addAttribute("authOk", authOk);
		} else {
			model.addAttribute("authOk", authOk);
		}
		return "front/user/join_auth_result";
	}
	
	/*
	 * 패널티 상품 모달 팝업 띄우기 위한 Data셋팅
	 */
	@RequestMapping(value = "/penalty_modal", method = RequestMethod.GET)
	public String selectPenaltyModalList(@RequestParam Map<String,Object> map, ModelMap model, HttpServletResponse response) throws Exception {
		
		List<Map<String, Object>> penaltyList = frontService.selectPenaltyModalList(map);
		
		model.addAttribute("penaltyList", penaltyList);
		
		return "front/modal/penaltymodal";
	}
	
	
}
