<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<%@ include file="/WEB-INF/include/gnb.jsp" %>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
</head>

<body class="homepage">
	<div id="page-wrapper">

		<!-- Header -->
		<div id="header">

			<!-- Inner -->
			<div class="inner">
				<header>
					<h1 style="text-shadow: 2px 2px 2px black;">당신의 목표달성을 위해 함께하겠습니다</h1>
					<hr>
					<p style="text-shadow: 2px 2px 2px black;">여러분의 <span style="font-size:32px; font-weight:bold; color:#f9d9e4;
					                        text-shadow: 1px 1px 1px black;">다짐</span>을 적어주세요</p>
					<p><img src="<c:url value='/resources/images/dit.png'/>"></p>
				</header>
				
				<footer>
					<a href="${pageContext.request.contextPath}/goals" class="button circled scrolly">Start</a>
				</footer>
				
				
			</div>

			<!-- Nav -->
			<nav id="nav">
				<ul>
					<li><a href="${pageContext.request.contextPath}/index">DoIt,Together</a></li>
					
					<li>
						<a href="${pageContext.request.contextPath}/introduces">소개</a>
						<ul>
							<li><a href="${pageContext.request.contextPath}/introduces/#aboutDit">DIT소개</a></li>
							<li><a href="${pageContext.request.contextPath}/introduces/#aboutWe">팀원소개</a></li>
						</ul>
					</li>
					<li><a href="${pageContext.request.contextPath}/goals">목표달성</a></li>
					<li><a href="${pageContext.request.contextPath}/notices">공지사항</a></li>
					
					<c:choose>
						<c:when test="${sessionIdx != 'null' && sessionId != 'null' && sessionName != 'null' && sessionNickName != 'null'}">
							<li>
								<a href="#"><c:out value="${sessionNickName}"></c:out>&hellip;</a>
								<ul>
									<c:if test="${!fn:contains(sessionNickName, 'facebook') && !fn:contains(sessionNickName, 'kakao_talk')}">
										<li><a href="${pageContext.request.contextPath}/mypages/${sessionIdx}">비밀번호 수정</a></li>
									</c:if>
									
										<li><a href="${pageContext.request.contextPath}/mypages/goals">지난 목표들</a></li>
										<li><a href="${pageContext.request.contextPath}/users/logout">로그아웃</a></li>
								</ul>
							</li>
						</c:when>
						<c:otherwise>
							<li><a href="${pageContext.request.contextPath}/users/joinform">회원가입</a></li>
							<li><a href="${pageContext.request.contextPath}/users/login">로그인</a></li>
						</c:otherwise>
					</c:choose>
					
				</ul>
			</nav>

		</div>			
	</div>
