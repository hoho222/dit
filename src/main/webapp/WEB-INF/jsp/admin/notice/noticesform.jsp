<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<%@ include file="/WEB-INF/include/navi.jsp" %>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script type="text/javascript">
function validSubmit() {
	var f = document.noticeFrm;
	
	if(f.title.value == ""){
		alert("제목을 입력해주세요!");
		f.title.focus();
		return false;
	}
	
	if(f.contents.value == ""){
		alert("내용을 입력해주세요!");
		f.contents.focus();
		return false;
	}
	
	f.action="notices"
	f.submit();
}
</script>

</head>
<body>

<form name="noticeFrm" method="POST">
	<input type="hidden" name="writerIdx" value="${sessionAdminIdx}"/>
	<input type="hidden" name="writerId" value="${sessionAdminId}"/>
	<input type="hidden" name="writerName" value="${sessionAdminName}"/>
	제목 : <input type="text" name="title"><br>
	내용 : <textarea name="contents" rows="3" cols="60"></textarea><br>
	<input type="submit" class="btn btn-default btn-sm" value="등록" onclick="validSubmit();"/>
</form>

</body>
</html>