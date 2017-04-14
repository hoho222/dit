<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>이메일인증</title>
<script type="text/javascript">

function check() {
	var f = document.authFrm;
	var authnoInput = f.authnoInput.value;
	
	if(authnoInput == ""){
		alert("인증번호를 입력하세요!");
		f.authnoInput.focus();
		return false;
	}
	
	f.action = "joinauth/result";
	f.submit();
}
</script>

</head>

<body>

<center>
	<h3>인증번호 7자리를 입력하세요.</h3>
	
	<div>
		<form name="authFrm" method="post">
			<input type="text" id="authnoInput" name="authnoInput" maxlength="7"/>
			<input type="button" value="인증" onclick="check();"/>
		</form>
	</div>
</center>

</body>
<%@ include file="/WEB-INF/include/foot.jsp" %>