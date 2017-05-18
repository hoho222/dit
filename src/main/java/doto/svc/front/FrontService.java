package doto.svc.front;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

@Service("frontService")
public interface FrontService {
	
	/**
    * 공지사항 리스트 Read
    * @throws Exception the exception
    */
	List<Map<String, Object>> selectNoticeList() throws Exception;
	
	/**
    * 공지사항 상세(1건) Read
    * @throws Exception the exception
    */
	Map<String, Object> selectNoticeDetail(String idx) throws Exception;
	
	/**
    * 공지사항 상세Read 시, 해당 글 카운트 1up
    * @throws Exception the exception
    */
	void updateNoticeHitCnt(String idx) throws Exception;
	
	/**
    * 목표상세 -> 주기체크 -> 1 cnt up!
    * @throws Exception the exception
    */
	boolean updateGoalPeriodHit(@RequestParam Map<String,Object> map) throws Exception;
	
	/**
    * 목표 1건 (상세) 업데이트
    * @throws Exception the exception
    */
	void updateGoal(@RequestParam Map<String,Object> map) throws Exception;
	
	/**
    * 목표달성 리스트 Read
    * @throws Exception the exception
    */
	List<Map<String, Object>> selectGoalList(@RequestParam Map<String,Object> map) throws Exception;
	
	/**
    * 목표달성 상세(1건) Read
    * @throws Exception the exception
    */
	Map<String, Object> selectGoalDetail(String idx) throws Exception;
	
	/**
    * 목표달성 상세(1건) Read
    * @throws Exception the exception
    */
	Map<String, Object> selectMemberDetail2(String idx) throws Exception;
	
	/**
    * 목표달성 상세 -> 코멘트 리스트 Read
    * @throws Exception the exception
    */
	List<Map<String, Object>> selectGoalCommentList(String idx) throws Exception;
	
	/**
    * 목표달성 상세 -> 소감(목표:소감 1:1관계임) Read
    * @throws Exception the exception
    */
	Map<String, Object> selectGoalResult(String idx) throws Exception;
	
	/**
    * 목표달성 Create
    * @throws Exception the exception
    */
	void insertGoal(Map<String, Object> map) throws Exception;
	
	/**
    * 목표 상세 -> 코멘트 Create
    * @throws Exception the exception
    */
	void insertGoalComment(Map<String, Object> map, HttpServletRequest request) throws Exception;
	
	/**
    * 목표 상세 -> 코멘트 Update or Delete (처리)
    * @throws Exception the exception
    */
	void processGoalCommentAct(Map<String, Object> map, HttpServletRequest request) throws Exception;
	
	/**
    * 목표 상세 -> 성공or실패 소감 Create
    * @throws Exception the exception
    */
	void insertGoalResult(Map<String, Object> map, HttpServletRequest request) throws Exception;
	
	/**
    * 회원 상세(1건) Read
    * @throws Exception the exception
    */
	Map<String, Object> selectMemberDetail(Map<String, Object> map) throws Exception;
	
	/**
	* 회원 정보 update (비밀번호)
	* @throws Exception the exception
	*/
	boolean updateMemberInfo(@RequestParam Map<String,Object> map) throws Exception;
	
	/**
    * 회원 Create
    * @throws Exception the exception
    */
	void insertMember(Map<String, Object> map) throws Exception;
	
	/**
    * 페이스북 회원 Create
    * @throws Exception the exception
    */
	boolean insertMemberFb(Map<String, Object> map, HttpServletRequest request) throws Exception;
	
	/**
    * 카카오톡 회원 Create
    * @throws Exception the exception
    */
	boolean insertMemberKakao(Map<String, Object> map, HttpServletRequest request) throws Exception;

	/**
    * 회원 가입 시 이메일 주소 중복확인
    * @return true, 중복안됨 / false, 중복됨
    * @throws Exception the exception
    */
	boolean memberOverlap(Map<String,Object> map) throws Exception;
	
	/**
    * 회원 가입 시 이메일 인증
    * @throws Exception the exception
    */
	Map<String, Object> memberAuth(Map<String,Object> map, HttpServletRequest request) throws Exception;
	
	/**
    * 회원 가입 시 이메일 인증 ACT
    * @throws Exception the exception
    */
	boolean memberAuthAct(Map<String,Object> map, HttpSession session) throws Exception;
	
	/**
    * 로그인 성공여부 파악 
    * @return true, 로그인성공 / false, 로그인실패
    * @throws Exception the exception
    */
	boolean isLoginOk(Map<String,Object> map, HttpServletResponse response, HttpServletRequest request) throws Exception;
	
	/**
    * 목표설정 -> 패널티 모달 창 Data 불러오기
    * @throws Exception the exception
    */
	List<Map<String, Object>> selectPenaltyModalList(@RequestParam Map<String,Object> map) throws Exception;

}
