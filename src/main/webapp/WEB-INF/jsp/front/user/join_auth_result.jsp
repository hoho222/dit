<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>이메일인증</title>
<script type="text/javascript">
window.onload = function(){
    if(${authOk}){
    	alert("인증성공!");
		opener.document.getElementById("emailAuthFin").innerHTML="<font color='blue'>인증완료</font>";
		opener.document.getElementById("isEmailAuthOk").value="T";
		opener.document.getElementById("emailFront").readOnly = true;
		opener.document.getElementById("emailBack").readOnly = true;
		self.close();
    } else {
    	alert("인증번호가 유효하지 않습니다. 다시 인증버튼을 눌러 인증을 진행해주세요.");
    	self.close();
    }
}
</script>

</head>
<body>


</body>
</html>