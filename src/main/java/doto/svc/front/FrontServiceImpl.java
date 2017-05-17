package doto.svc.front;

import java.net.InetAddress;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.annotation.Resource;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import doto.common.logger.CommonInterceptor;
import doto.common.util.FileUtils;
import doto.dao.FrontDAO;
import doto.mail.Email;
import doto.mail.EmailSender;
import doto.mail.MyAuthentication;


@Service("frontService")
public class FrontServiceImpl  implements FrontService {
	
	protected Log log = LogFactory.getLog(CommonInterceptor.class);
	
	@Autowired
	private EmailSender emailSender;
	 
	@Autowired
	private Email email;

	@Resource(name="fileUtils")
    private FileUtils fileUtils;

	@Resource(name="frontDAO")
	private FrontDAO frontDAO;
	
	@Override
	public List<Map<String, Object>> selectNoticeList() throws Exception {
		return frontDAO.selectNoticeList();
	}
	
	@Override
	public Map<String, Object> selectNoticeDetail(String idx) throws Exception {
		
		return frontDAO.selectNoticeDetail(idx);
	}
	
	@Override
	public void updateNoticeHitCnt(String idx) throws Exception {
		
		frontDAO.updateNoticeHitCnt(idx);
		
	}
	
	@Override
	public boolean updateGoalPeriodHit(@RequestParam Map<String,Object> map) throws Exception {
		//업데이트 하기 전, 카운트 수 부터 비교
		String idx = map.get("idx").toString();
		Map<String,Object> goalMap = frontDAO.selectGoalDetail(idx);
		
		String end =  goalMap.get("END_DT").toString(); //종료일(DATE)
		String checkReg =  goalMap.get("GOAL_CHECK_PERIOD_HIT_REGDATE").toString(); //체크일(DATE)
		String today =  goalMap.get("TODAY").toString(); //오늘(DATE)
		String checkDay =  goalMap.get("GOAL_CHECK_PERIOD_HIT").toString(); //주기일수(얘는 그냥 숫자임)
		long checkDays =  Long.parseLong(checkDay);
		
		try {
	        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
	        Date endDate = formatter.parse(end);
	        Date checkRegDate = formatter.parse(checkReg);
	        Date todayDate = formatter.parse(today);
	 
	        // 시간차이를 시간,분,초를 곱한 값으로 나누면 하루 단위가 나옴
	        long diff = todayDate.getTime() - checkRegDate.getTime();
	        long diffDays = diff / (24 * 60 * 60 * 1000);
	        
	        long diff2 = todayDate.getTime() - endDate.getTime();
	        long diffDays2 = diff2 / (24 * 60 * 60 * 1000);
	 
	        //오늘과 체크한 날이 같은 날일 경우 -> 체크못함
	        if(diffDays == 0){
	        	if (log.isDebugEnabled()) {
	        		log.debug("체크불가이유 : 오늘과 체크한 날이 같은 날일 경우 | 오늘 - 체크한날 일수 = "+diffDays);
	        	}
	        	return false;
	        }
	        
	        //체크한 날이 주기일 수 보다 적은 경우 -> 체크못함
	        if(diffDays < checkDays){
	        	if (log.isDebugEnabled()) {
	        		log.debug("체크불가이유 : 체크한 날이 주기일 수 보다 적은 경우 | 오늘 - 체크한날 일수 = "+diffDays + " | 주기일수>> "+checkDays);
	        	}
	        	return false;
	        }
	        
	        //오늘이 목표 종료일이거나 종료일이 지났을 경우 -> 체크못함
	        if(diffDays2 > 0){
	        	if (log.isDebugEnabled()) {
	        		log.debug("체크불가이유 : 종료일이 지난 경우 | 오늘 - 종료일 일수 = "+diffDays2);
	        	}
	        	return false;
	        }
	        
	        int periodHitInt = Integer.parseInt((map.get("periodHit").toString()));
			
			map.put("periodHitInt", periodHitInt);
			
			frontDAO.updateGoalPeriodHit(map);
			
			return true;
	        
	    } catch (ParseException e) {
	        e.printStackTrace();
	    }

		return true;
	}
	
	@Override
	public void updateGoal(@RequestParam Map<String,Object> map) throws Exception {
		
		frontDAO.updateGoal(map);
		
	}
	
	@Override
	public List<Map<String, Object>> selectGoalList(@RequestParam Map<String,Object> map) throws Exception {
		
		return frontDAO.selectGoalList(map);
	}
	
	@Override
	public Map<String, Object> selectGoalDetail(String idx) throws Exception {
		
		return frontDAO.selectGoalDetail(idx);
	}
	
	@Override
	public Map<String, Object> selectMemberDetail2(String idx) throws Exception {
		
		return frontDAO.selectMemberDetail2(idx);
	}
	
	@Override
	public List<Map<String, Object>> selectGoalCommentList(String idx) throws Exception {
		return frontDAO.selectGoalCommentList(idx);
	}
	
	@Override
	public Map<String, Object> selectGoalResult(String idx) throws Exception {
		
		return frontDAO.selectGoalResult(idx);
	}
	
	@Override
	public void insertGoal(Map<String, Object> map) throws Exception {
		
		String goalCheckPeriod = map.get("goalCheckPeriod").toString();
		String has_goal_check_period_value = map.get("has_goal_check_period_value").toString();
		
		if("N".equals(has_goal_check_period_value)){
			if(goalCheckPeriod == null || "".equals(goalCheckPeriod)){
				map.put("goalCheckPeriod", "0");
			}
		}
		
		frontDAO.insertGoal(map);
	}
	
	@Override
	public void insertGoalComment(Map<String, Object> map, HttpServletRequest request) throws Exception {
		
		frontDAO.insertGoalComment(map);
		
		map.put("GB", "commentImg");
		
		List<Map<String, Object>> list = fileUtils.parseInsertFileInfo(map, request);
		
		for(int i=0; i<list.size(); i++){
			frontDAO.insertGoalCommentImg(list.get(i));
		}
		
	}
	
	@Override
	public void processGoalCommentAct(Map<String, Object> map, HttpServletRequest request) throws Exception {
		
		System.out.println("삭제 뽕 > "+map);
		
		//코멘트 내용 수정
		if("EDIT".equals(map.get("mode").toString())){
			frontDAO.updateGoalComment(map);
		} 
		
		//코멘트 삭제
		else if("DEL".equals(map.get("mode").toString())){
			frontDAO.deleteGoalComment(map);
		}
		
	}
	
	@Override
	public void insertGoalResult(Map<String, Object> map, HttpServletRequest request) throws Exception {
		
		frontDAO.insertGoalResult(map);
		
		String idx = map.get("goalIdx").toString();
		Map<String, Object> goalDetailMap = frontDAO.selectGoalDetail(idx);
		String hasGoalChecker = goalDetailMap.get("HAS_GOAL_CHECKER").toString();
		
		if(goalDetailMap != null){
			if("Y".equals(hasGoalChecker) && !"".equals(goalDetailMap.get("GOAL_CHECKER").toString()) && !"".equals(goalDetailMap.get("GOAL_CHECKER_EMAIL").toString())){
				//목표 체크자가 타인일 경우, 해당 사람에게 메일전송
				String goalCheckerEmailId = goalDetailMap.get("GOAL_CHECKER_EMAIL").toString();
				String goalCheckerName = goalDetailMap.get("GOAL_CHECKER").toString();
				String writerName = goalDetailMap.get("WRITER_NAME").toString();
				
				String goalTitle = goalDetailMap.get("GOAL_TITLE").toString();
				String goalContents = goalDetailMap.get("GOAL_CONTENTS").toString();
				
				String isSuccess = goalDetailMap.get("IS_SUCCESS").toString();
				String successStr = "-";
				if("Y".equals(isSuccess) && !"D".equals(isSuccess)){
					successStr = "성공!";
				} else if ("N".equals(isSuccess) && !"D".equals(isSuccess)){
					successStr = "실패;(";
				}
				
				/*email.setReceiver(goalCheckerEmailId); 										  			
				email.setSubject("[DOit,TOgether] "+writerName+"님의 목표 달성 결과입니다.");   
				email.setContent("안녕하세요 " + goalCheckerName + "님, " + writerName + "님의 목표 달성은 "+successStr+" 했습니다.\n\n"+
								 "목표 타이틀 : "+goalTitle+"\n"+
								 "목표 세부내용 : "+goalContents+"\n");
				emailSender.SendEmail(email);*/
				
				//메일발송
				String subject = "[DoIt,Together]이메일 인증 번호가 도착했습니다.";                       
				String msgText = "안녕하세요 " + goalCheckerName + "님, " + writerName + "님의 목표 달성은 "+successStr+" 했습니다.\n\n"+
								 "목표 타이틀 : "+goalTitle+"\n"+
								 "목표 세부내용 : "+goalContents+"\n";     
				String host = "mw-002.cafe24.com";                
				String from = "master@doit2gether.tk";                  
				String to = goalCheckerEmailId;                        

				Properties props = new Properties();
				props.put("mail.smtp.host", host);
				props.put("mail.smtp.auth","true");

				Authenticator auth = new MyAuthentication();
				Session sess = Session.getInstance(props, auth);

				try {
				        Message msg = new MimeMessage(sess);
				        msg.setFrom(new InternetAddress(from));
				        InternetAddress[] address = {new InternetAddress(to)};
				        msg.setRecipients(Message.RecipientType.TO, address);
				        msg.setSubject(subject);
				        msg.setSentDate(new Date());
				        msg.setText(msgText);

				        Transport.send(msg);
				        System.out.println("목표달성 결과 메일 전송 성공>_<");
				} catch (MessagingException mex) {
						System.out.println(mex.getMessage()+"<br>"+mex.getCause());
						System.out.println("목표달성 결과 메일 전송 실패T^T.");
				}
				
			}
					
		}
		
		map.put("GB", "resultImg");
		
		List<Map<String, Object>> list = fileUtils.parseInsertFileInfo(map, request);
		
		for(int i=0; i<list.size(); i++){
			frontDAO.insertGoalResultImg(list.get(i));
		}
		
	}
	
	@Override
	public Map<String, Object> selectMemberDetail(Map<String, Object> map) throws Exception {
		
		return frontDAO.selectMember(map);
	}
	
	@Override
	public boolean updateMemberInfo(@RequestParam Map<String,Object> map) throws Exception {
		String idx = map.get("idx").toString();
		String password = map.get("password").toString();
		
		Map<String, Object> memberMap = frontDAO.selectMemberDetail2(idx);
		
		//해당 비밀번호가 해당 회원의 비밀번호가 맞는지부터 조회.
		if(password.equals(memberMap.get("PWD").toString())){
			frontDAO.updateMemberInfo(map);
			return true;
		} else {
			//비밀번호 틀리므로 회원정보 수정 불가능
			return false;
		}
		
	}
	
	@Override
	public void insertMember(Map<String, Object> map) throws Exception {
		
		String emailId = (map.get("emailFront")).toString() + "@" + (map.get("emailBack")).toString();
		
		map.put("emailId", emailId);
		
		frontDAO.insertMember(map);
	}
	
	@Override
	public boolean insertMemberFb(Map<String, Object> map, HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();
		
		//페이스북으로 회원가입 하기전, 이미 가입된 회원인지 부터 확인
		Map<String, Object> alreadyMember = frontDAO.selectMember(map);
		boolean isFirstFbLogin = false;
		
		//이미 해당 페이스북ID로 가입된 회원이 아닐때만 insert 됨
		if(alreadyMember == null) {
			
			isFirstFbLogin = true;
			String fbName = (map.get("fbName")).toString();
			
			//페이스북 회원은 닉네임을 하단의 형식으로 지정해줌
			String fbNickName = fbName + "(facebook)";
			map.put("fbNickName", fbNickName);
			
			frontDAO.insertMemberFb(map);
		} else {
			//페이스북 로그인을 처음하지 않은 사람은 여기서 세션에 해당 fbId값 박아서, 그 세션값으로 여기저기서 쓰면될듯
			session.setAttribute("loginIdx", alreadyMember.get("IDX"));
			session.setAttribute("loginId", alreadyMember.get("EMAIL_ID"));
			session.setAttribute("loginName", alreadyMember.get("NAME"));
			session.setAttribute("loginNickName", alreadyMember.get("NICKNAME"));
			session.setAttribute("loginFbId", alreadyMember.get("FB_ID"));
			
			//ip 주소 정보 가져오기
			InetAddress local = InetAddress.getLocalHost();
			String ip = local.getHostAddress();
			
			//로그인접속 정보 T_ACCESS_LOG 에 저장
			Map<String, Object> logMap = new HashMap<String, Object>();
			logMap.put("memberIdx", alreadyMember.get("IDX"));
			logMap.put("memberIp", ip);
			logMap.put("memberAccessPath", "faceBook");
			frontDAO.insertMemberAccessLog(logMap);
		}
		
		return isFirstFbLogin;
	}
	
	@Override
	public void insertMemberKakao(Map<String, Object> map, HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();
		
		//카카오톡으로 회원가입 하기전, 이미 가입된 회원인지 부터 확인
		Map<String, Object> alreadyMember = frontDAO.selectMember(map);
		
		//이미 해당 카카오톡ID로 가입된 회원이 아닐때만 insert 됨
		if(alreadyMember == null) {
			frontDAO.insertMemberKakao(map);
		} else {
			//카카오톡 로그인을 처음하지 않은 사람은 여기서 세션에 해당 kakaoId값 박아서, 그 세션값으로 여기저기서 쓰면될듯
			session.setAttribute("loginIdx", alreadyMember.get("IDX"));
			session.setAttribute("loginId", alreadyMember.get("EMAIL_ID"));
			session.setAttribute("loginName", alreadyMember.get("NAME"));
			session.setAttribute("loginNickName", alreadyMember.get("NICKNAME"));
			session.setAttribute("loginKakaoId", alreadyMember.get("KAKAO_ID"));
			
			//ip 주소 정보 가져오기
			InetAddress local = InetAddress.getLocalHost();
			String ip = local.getHostAddress();
			
			//로그인접속 정보 T_ACCESS_LOG 에 저장
			Map<String, Object> logMap = new HashMap<String, Object>();
			logMap.put("memberIdx", alreadyMember.get("IDX"));
			logMap.put("memberIp", ip);
			logMap.put("memberAccessPath", "kakaoTalk");
			frontDAO.insertMemberAccessLog(logMap);
		}
		
	}
	
	@Override
	public boolean memberOverlap(Map<String,Object> map) throws Exception{
		
		Map<String, Object> selectUser = frontDAO.selectMember(map);
		
		if(selectUser != null) {
			return false;
		} else {
			return true;
		}
		
	}

	@Override
	public Map<String, Object> memberAuth(Map<String,Object> map, HttpServletRequest request) throws Exception {
	
		String emailId = map.get("emailAddr").toString();
		
		String authNo = EmailSender.RandomNum();
		
		/*email.setReceiver(emailId); 										  //메일 받을사람
		email.setSubject("[DOit,TOgether]이메일 인증 번호가 도착했습니다.");  //메일 제목
		email.setContent("이메일 인증번호 ["+authNo+"]");					  //메일 내용
		
		System.out.println("이메일 >> "+email);
		emailSender.SendEmail(email);*/
		
		String subject = "[DoIt,Together]이메일 인증 번호가 도착했습니다.";                       
		String msgText = "하단의 인증번호를 인증창에 입력해주세요.\n이메일 인증번호 ["+authNo+"]";       
		String host = "mw-002.cafe24.com";                
		String from = "master@doit2gether.tk";                  
		String to = emailId;                        

		Properties props = new Properties();
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.auth","true");

		Authenticator auth = new MyAuthentication();
		Session sess = Session.getInstance(props, auth);

		try {
		        Message msg = new MimeMessage(sess);
		        msg.setFrom(new InternetAddress(from));
		        InternetAddress[] address = {new InternetAddress(to)};
		        msg.setRecipients(Message.RecipientType.TO, address);
		        msg.setSubject(subject);
		        msg.setSentDate(new Date());
		        msg.setText(msgText);

		        Transport.send(msg);
		        System.out.println("인증 메일 전송 성공>_<");
		} catch (MessagingException mex) {
				System.out.println(mex.getMessage()+"<br>"+mex.getCause());
				System.out.println("인증 메일 전송 실패T^T.");
		}
		
		map.put("authNo", authNo);
		
		//인증번호 세션에 저장
		HttpSession session = request.getSession();
		session.setAttribute("emailAuthNo", authNo);
		
		if (log.isDebugEnabled()) {
            log.debug("------- Email Auth No : " + authNo);
        }
		
		return map;
	}
	
	@Override
	public boolean memberAuthAct(Map<String,Object> map, HttpSession session) throws Exception {
		String authnoInput = map.get("authnoInput").toString();
		String emailAuthNo = (String)session.getAttribute("emailAuthNo");
		
		if(!emailAuthNo.equals("") && !authnoInput.equals("") && authnoInput.equals(emailAuthNo)){
			return true;
		} else {
			return false;
		}
		
	}
	
	@Override
	public boolean isLoginOk(Map<String,Object> map, HttpServletResponse response, HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();
		
		String memberCntStr = frontDAO.isMemberCnt(map);
		
		if(memberCntStr != null) {
			int memberCnt = Integer.parseInt(memberCntStr);
			if(memberCnt == 1) {
				Map<String, Object> selectMemberInfo = frontDAO.selectMember(map);
				
				//여기에 로그인ID, 로그인자 이름 따로 받아와서 세션에 넣어줌
				session.setAttribute("loginIdx", selectMemberInfo.get("IDX"));
				session.setAttribute("loginId", selectMemberInfo.get("EMAIL_ID"));
				session.setAttribute("loginName", selectMemberInfo.get("NAME"));
				session.setAttribute("loginNickName", selectMemberInfo.get("NICKNAME"));
				
				//ip 주소 정보 가져오기
				InetAddress local = InetAddress.getLocalHost();
				String ip = local.getHostAddress();
				
				//로그인접속 정보 T_ACCESS_LOG 에 저장
				Map<String, Object> logMap = new HashMap<String, Object>();
				logMap.put("memberIdx", selectMemberInfo.get("IDX"));
				logMap.put("memberIp", ip);
				logMap.put("memberAccessPath", "doitTogether");
				frontDAO.insertMemberAccessLog(logMap);
				
				return true;
			} else {
			    return false;
			}
		} else {
		    return false;
		}
	}
	
	@Override
	public List<Map<String, Object>> selectPenaltyModalList(@RequestParam Map<String,Object> map) throws Exception {
		
		List<Map<String, Object>> penaltyList = frontDAO.selectPenaltyModalList(map);
		
		return penaltyList;
	}
}
