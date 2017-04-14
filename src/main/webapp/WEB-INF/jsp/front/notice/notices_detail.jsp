<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<%@ include file="/WEB-INF/include/gnb.jsp" %>
<%@ include file="/WEB-INF/include/top.jsp" %>
<%@ include file="/WEB-INF/include/head.jsp" %>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

</head>
<body>
<h2>${idx} 번 글 입니다.</h2>
제목 : ${noticeMap.TITLE} <br>
내용 : ${noticeMap.CONTENTS} <br>
조회수 : ${noticeMap.HIT_CNT} <br>
등록일 : ${noticeMap.CREATE_DT} <br>
작성자ID : ${noticeMap.WRITER_ID}
</body>
<%@ include file="/WEB-INF/include/foot.jsp" %>
</html>