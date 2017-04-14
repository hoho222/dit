<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 

</head>
<body>

<c:set var="sessionIdx"><%= session.getAttribute("loginIdx") %></c:set>
<c:set var="sessionId"><%= (String)session.getAttribute("loginId") %></c:set>
<c:set var="sessionName"><%= (String)session.getAttribute("loginName") %></c:set>
<c:set var="sessionNickName"><%= (String)session.getAttribute("loginNickName") %></c:set> 

<div id="top" style="background-color:#FFA7A7">
	
	<br>
	
	<c:choose>
	<c:when test="${sessionIdx != 'null' && sessionId != 'null' && sessionName != 'null' && sessionNickName != 'null'}">
		<div align="right" style="float: right;">
			<div class="dropdown">
			    <button class="btn btn-default dropdown-toggle" type="button" id="menu1" data-toggle="dropdown"><c:out value="${sessionNickName}"></c:out>
			    <span class="caret"></span></button>
			    <ul class="dropdown-menu" role="menu" aria-labelledby="menu1">
			      <li role="presentation"><a role="menuitem" tabindex="-1" href="${pageContext.request.contextPath}/mypages/${sessionIdx}">마이페이지</a></li>
			      <li role="presentation"><a role="menuitem" tabindex="-1" href="${pageContext.request.contextPath}/mypages/goals">지난 목표들</a></li>
			      <li role="presentation" class="divider"></li>
			      <li role="presentation"><a role="menuitem" tabindex="-1" href="${pageContext.request.contextPath}/users/logout">로그아웃</a></li>
			    </ul>
		  	</div>
			
		</div>
	</c:when>
	<c:otherwise>
		<div align="right" style="float: right;">
			<a href="${pageContext.request.contextPath}/users/joinform">회원가입</a>
			<a href="${pageContext.request.contextPath}/users/login">간편로그인</a>
		</div>
	</c:otherwise>
	</c:choose>
	
</div>

</body>
</html>