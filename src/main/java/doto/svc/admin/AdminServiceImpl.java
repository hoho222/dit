package doto.svc.admin;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import doto.dao.AdminDAO;

@Service("adminService")
public class AdminServiceImpl implements AdminService{
	
	@Resource(name="adminDAO")
	private AdminDAO adminDAO;
	
	@Override
	public Map<String,Object> findStatus() throws Exception {
		
		HashMap<String,Object> params = new HashMap<String,Object>();
		
		Map<String,Object> statusResult = new HashMap<String,Object>();
		
		params.clear();
		String memCntTotal = adminDAO.selectMemberCnt(params);
		String goalCntTotal = adminDAO.selectGoalCnt(params);
		
		//오늘날짜 구하기
		SimpleDateFormat formatterS = new SimpleDateFormat ( "yyyy-MM-dd 00:00:00", Locale.KOREA );
		SimpleDateFormat formatterE = new SimpleDateFormat ( "yyyy-MM-dd 23:59:59", Locale.KOREA );
		Date currentTime = new Date ( );
		String TodayStart = formatterS.format ( currentTime );
		String TodayEnd = formatterE.format ( currentTime );
		
		params.put("isToday", "OK");
		params.put("TodayStart", TodayStart);
		params.put("TodayEnd", TodayEnd);
		String memCntToday = adminDAO.selectMemberCnt(params);
		String goalCntToday = adminDAO.selectGoalCnt(params);
		
		statusResult.put("MEM_CNT_TOTAL", memCntTotal);
		statusResult.put("GOAL_CNT_TOTAL",goalCntTotal);
		statusResult.put("MEM_CNT_TODAY", memCntToday);
		statusResult.put("GOAL_CNT_TODAY", goalCntToday);
		
		return statusResult;
	}
	
	@Override
	public boolean isAdminLoginOk(Map<String,Object> map, HttpServletResponse response, HttpServletRequest request) throws Exception {
		
		HttpSession session = request.getSession();
		
		String memberCntStr = adminDAO.isAdminCnt(map);
		
		if(memberCntStr != null) {
			int memberCnt = Integer.parseInt(memberCntStr);
			if(memberCnt == 1) {
				Map<String, Object> selectAdminInfo = adminDAO.selectAdmin(map);
				
				//여기에 어드민 로그인ID, 로그인자 이름 따로 받아와서 세션에 넣어줌
				session.setAttribute("adminLoginIdx", selectAdminInfo.get("IDX"));
				session.setAttribute("adminLoginId", selectAdminInfo.get("ID"));
				session.setAttribute("adminLoginName", selectAdminInfo.get("NAME"));
				
				//어드민 LAST_ACCESS_DT 현재일자로 update(추후 보완 깽)
				
				return true;
			} else {
			    return false;
			}
		} else {
		    return false;
		}
	}
	
	@Override
	public List<Map<String, Object>> selectPenaltyList() throws Exception {
		return adminDAO.selectPenaltyList();
	}
	
	@Override
	public boolean insertPenalty(Map<String, Object> map) throws Exception {
		
		adminDAO.insertPenalty(map);
		
		return true;
	}
	
	@Override
	public List<Map<String, Object>> selectNoticeList() throws Exception {
		return adminDAO.selectNoticeList();
	}
	
	@Override
	public void insertNotice(Map<String, Object> map) throws Exception {
		
		adminDAO.insertNotice(map);
	}

}
