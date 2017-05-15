<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<%@ include file="/WEB-INF/include/gnb.jsp" %>
<%@ include file="/WEB-INF/include/top.jsp" %>
<%@ include file="/WEB-INF/include/head.jsp" %>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script type="text/javascript">
function validSubmit() {
	var f = document.frm;
	
	if(f.password.value == ""){
		alert("현재 비밀번호를 입력해주세요");
		f.password.focus();
		return false;
	}
	
	if(f.newPassword.value == ""){
		alert("변경할 비밀번호를 입력해주세요");
		f.newPasswordRe.focus();
		return false;
	}
	
	if(f.newPasswordRe.value == ""){
		alert("변경할 비밀번호 확인도 입력해주세요");
		f.newPasswordRe.focus();
		return false;
	}
	
	if(f.newPassword.value != f.newPasswordRe.value){
		alert("변경할 비밀번호와 비밀번호 확인을 똑같이 입력해주세요!");
		return false;
	}
	
	f.action="change";
	f.submit();
}
</script>

</head>
<body>

<center>
<h2>비밀번호 변경</h2>
<form id="frm" name="frm" method="post">
	<input type="hidden" name="idx" value="${memberMap.IDX}"/>
	아이디 : ${memberMap.EMAIL_ID} <br>
	현재 비밀번호 : <input type="password" name="password"/><br>
	변경할 비밀번호 : <input type="password" name="newPassword"/><br>
	변경할 비밀번호 확인 : <input type="password" name="newPasswordRe"/><br>
	<%-- 닉네임 : <input type="text" name="newNickName" value="${memberMap.NICKNAME}"/><br> --%>
	<%-- 성별 : ${memberMap.GENDER} <br>
	생일 : ${memberMap.BIRTH_DT} <br> --%>
	<input type="button" value="변경" onclick="validSubmit();"/>
</form>
</center>

</body>
<%@ include file="/WEB-INF/include/foot.jsp" %>
</html>