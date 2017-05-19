<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<%@ include file="/WEB-INF/include/gnb.jsp" %>

</head>
<body>

<c:set var="sessionIdx"><%= session.getAttribute("loginIdx") %></c:set>
<c:set var="sessionId"><%= (String)session.getAttribute("loginId") %></c:set>
<c:set var="sessionName"><%= (String)session.getAttribute("loginName") %></c:set>
<c:set var="sessionNickName"><%= (String)session.getAttribute("loginNickName") %></c:set> 

</body>
</html>