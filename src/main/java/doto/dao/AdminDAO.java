package doto.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository("adminDAO")
public class AdminDAO extends AbstractDAO {
	
	public String isAdminCnt(Map<String, Object> map) {
		
		return (String)selectOne("admin.isAdminCnt", map);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectAdmin(Map<String, Object> map) {
		
		return (Map<String, Object>)selectOne("admin.selectAdmin", map);
	}

	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectPenaltyList() {
		
		return (List<Map<String, Object>>)selectList("admin.selectPenaltyList");
	}
	
	public void insertPenalty(Map<String, Object> map) throws Exception{
		insert("admin.insertPenalty", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectNoticeList() {
		
		return (List<Map<String, Object>>)selectList("admin.selectNoticeList");
	}
	
	public void insertNotice(Map<String, Object> map) throws Exception{
		insert("admin.insertNotice", map);
	}
}
