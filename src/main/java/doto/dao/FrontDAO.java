package doto.dao;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestParam;

@Repository("frontDAO")
public class FrontDAO extends AbstractDAO{

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectNoticeList() {
		
		return (List<Map<String, Object>>)selectList("front.selectNoticeList");
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectNoticeDetail(String idx) {
		
		return (Map<String, Object>)selectOne("front.selectNoticeDetail", idx);
	}
	
	public void updateNoticeHitCnt(String idx) throws Exception{
		update("front.updateNoticeHitCnt", idx);
	}
	
	public void updateGoalPeriodHit(@RequestParam Map<String,Object> map) throws Exception{
		System.out.println("띠바 왜 > "+map);
		update("front.updateGoal", map);
	}
	
	public void updateGoal(@RequestParam Map<String,Object> map) throws Exception{
		update("front.updateGoal", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectGoalList(@RequestParam Map<String,Object> map) {
		
		return (List<Map<String, Object>>)selectList("front.selectGoalList", map);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectGoalDetail(String idx) {
		
		return (Map<String, Object>)selectOne("front.selectGoalDetail", idx);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectMemberDetail2(String idx) {
		
		return (Map<String, Object>)selectOne("front.selectMemberDetail", idx);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectGoalCommentList(String idx) {
		
		return (List<Map<String, Object>>)selectList("front.selectGoalCommentList", idx);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectGoalResult(String idx) {
		
		return (Map<String, Object>)selectOne("front.selectGoalResult", idx);
	}
	
	public void insertGoal(Map<String, Object> map) throws Exception{
		insert("front.insertGoal", map);
	}
	
	public void insertGoalComment(Map<String, Object> map) throws Exception{
		insert("front.insertGoalComment", map);
	}
	
	public void insertGoalCommentImg(Map<String, Object> map) throws Exception{
		insert("front.insertGoalCommentImg", map);
	}
	
	public void insertGoalResult(Map<String, Object> map) throws Exception{
		insert("front.insertGoalResult", map);
	}
	
	public void insertGoalResultImg(Map<String, Object> map) throws Exception{
		insert("front.insertGoalResultImg", map);
	}
	
	public void insertMember(Map<String, Object> map) throws Exception{
		insert("front.insertMember", map);
	}
	
	public void insertMemberFb(Map<String, Object> map) throws Exception{
		insert("front.insertMemberFb", map);
	}
	
	public void insertMemberKakao(Map<String, Object> map) throws Exception{
		insert("front.insertMemberKakao", map);
	}
	
	public void insertMemberAccessLog(Map<String, Object> map) throws Exception{
		insert("front.insertMemberAccessLog", map);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectMember(Map<String, Object> map) {
		
		return (Map<String, Object>)selectOne("front.selectMember", map);
	}
	
	public String isMemberCnt(Map<String, Object> map) {
		
		return (String)selectOne("front.isMemberCnt", map);
	}
	
	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectPenaltyModalList(Map<String, Object> map) {
		
		return (List<Map<String, Object>>)selectList("front.selectPenaltyModalList", map);
	}
	
}
