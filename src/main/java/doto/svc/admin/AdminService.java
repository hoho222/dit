package doto.svc.admin;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public interface AdminService {

	/**
    * 어드민 로그인 성공여부 파악 
    * @return true, 로그인성공 / false, 로그인실패
    * @throws Exception the exception
    */
	boolean isAdminLoginOk(Map<String,Object> map, HttpServletResponse response, HttpServletRequest request) throws Exception;
	
	/**
    * 어드민 패널티 상품 리스트 Read
    * @throws Exception the exception
    */
	List<Map<String, Object>> selectPenaltyList() throws Exception;
	
	/**
    * 어드민 패널티 상품 Create
    * @throws Exception the exception
    */
	boolean insertPenalty(Map<String, Object> map) throws Exception;
	
	/**
    * 어드민 공지사항 리스트 Read
    * @throws Exception the exception
    */
	List<Map<String, Object>> selectNoticeList() throws Exception;
	
	/**
    * 어드민 공지사항 Create
    * @throws Exception the exception
    */
	void insertNotice(Map<String, Object> map) throws Exception;
	
}
