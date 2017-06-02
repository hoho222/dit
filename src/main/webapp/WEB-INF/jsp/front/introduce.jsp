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

<div id="page-wrapper">
<center>
	<div id="aboutDit" style="margin: 0 0 5% 0;">
		<div id="" class="section">
			<div class="s-container">
				<h2 class="section-title" style="transform: translateY(0px); opacity: 1;">HOW?</h2>
			</div>
		</div>
		
		<section id="banner">
			<header>
				<p>
					<img src="<c:url value='/resources/imgs/introduceDit_1.jpg'/>" style="width:100%; height: 100%;"/>
					<img src="<c:url value='/resources/imgs/introduceDit_2.jpg'/>" style="width:100%; height: 100%;"/>
					<img src="<c:url value='/resources/imgs/introduceDit_3.jpg'/>" style="width:100%; height: 100%;"/>
					<a href="${pageContext.request.contextPath}/goalsform"><button>목표를 등록하러 가 볼까요?</button></a>
				</p>
			</header>
		</section>
	</div>
	
	<hr>
	<br>
	
	<div id="aboutWe" >
		<div id="" class="section">
			<div class="s-container">
				<h2 class="section-title" style="transform: translateY(0px); opacity: 1;">WHO?</h2>
			</div>
		</div>
		
		<section id="banner">
			<header>
				<p>
					<img src="<c:url value='/resources/imgs/introduceWe.jpg'/>" style="width:100%; height: 100%;"/>
				</p>
			</header>
		</section>
	</div>
	
</center>
</div>

<%@ include file="/WEB-INF/include/foot.jsp" %>
</html>