package doto.svc.admin;

import java.net.InetAddress;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import doto.dao.AdminDAO;
import doto.dao.FrontDAO;

@Service("adminService")
public class AdminServiceImpl implements AdminService{
	
	@Resource(name="adminDAO")
	private AdminDAO adminDAO;
	
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
