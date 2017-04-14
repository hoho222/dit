<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>DIT admin</title>

<%@ include file="/WEB-INF/include/gnb.jsp" %>

</head>
<body>

<c:set var="sessionAdminId"><%= (String)session.getAttribute("adminLoginId") %></c:set>
<c:set var="sessionAdminName"><%= (String)session.getAttribute("adminLoginName") %></c:set>
<c:set var="sessionAdminIdx"><%= session.getAttribute("adminLoginIdx") %></c:set>


<ul>

<c:choose>
<c:when test="${sessionAdminId != 'null' && sessionAdminName != 'null'}">
	<li><a href="#">어드민회원 : <c:out value="${adminLoginName}"></c:out></a></li>
</c:when>
<c:otherwise>
</c:otherwise>
</c:choose>

	<li><a class="active" href="${pageContext.request.contextPath}/admin/index">Home</a></li>
	<li><a href="${pageContext.request.contextPath}/admin/penalty">패널티상품관리</a></li>
	<li><a href="${pageContext.request.contextPath}/admin/notices">공지사항관리</a></li>
	<li><a href="#contact">회원관리</a></li>
</ul>

</body>
</html>