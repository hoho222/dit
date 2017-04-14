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

</script>

</head>
<body>

<center>
<h2>내 정보</h2>
아이디 : ${memberMap.EMAIL_ID} <br>
닉네임 : ${memberMap.NICKNAME} <br>
성별 : ${memberMap.GENDER} <br>
생일 : ${memberMap.BIRTH_DT} <br>
</center>

</body>
<%@ include file="/WEB-INF/include/foot.jsp" %>
</html>