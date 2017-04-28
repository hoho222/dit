<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/WEB-INF/include/gnb.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body>

<div id="head">
   <div class="life">
   	<li class="logo"><a href="${pageContext.request.contextPath}/index">로고</a></li>
   </div>
   <!-- life e -->
   
    <div class="right">
		<ul class="menu">
               <li class="mainmenu01"><a href="#">소개</a></li>
               <li class="mainmenu02"><a href="${pageContext.request.contextPath}/goals">목표달성</a></li>
               <li class="mainmenu03"><a href="${pageContext.request.contextPath}/notices">공지사항</a></li>
               
               <c:choose>
				<c:when test="${sessionIdx != 'null' && sessionId != 'null' && sessionName != 'null' && sessionNickName != 'null'}">
					<li class="mainmenu04"><c:out value="${sessionNickName}"></c:out></li>
					<li class="mainmenu05"><a href="${pageContext.request.contextPath}/users/logout">로그아웃</a></li>
				</c:when>
				<c:otherwise>
					<li class="mainmenu04"><a href="${pageContext.request.contextPath}/users/joinform">회원가입</a></li>
					<li class="mainmenu05"><a href="${pageContext.request.contextPath}/users/login">로그인</a></li>
				</c:otherwise>
			</c:choose>
               
		</ul>
	</div>
</div>

</div>

</body>
</html>