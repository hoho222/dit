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

<center>

	<div id="" class="section">
		<div class="s-container">
			<h2 class="section-title" style="transform: translateY(0px); opacity: 1;">GOAL LIST</h2>
		</div>
	</div>
	
	<a href="goalsform"><input type="button" class="btn btn-primary btn-sm" value="목표 설정하기"/></a>
	
	<c:choose>
		<c:when test="${fn:length(goalList) > 0}">
			<section class="carousel">
				<div class="reel">
					<c:forEach items="${goalList }" var="row" varStatus="status">
						<article class="round-border">
							<a class="image featured">NO. ${status.count}</a><br>
							<header>
								<h3><a href="${pageContext.request.contextPath}/goals/${row.IDX}">${row.GOAL_TITLE }</a></h3>
							</header>
							<p>
								${row.GOAL_CONTENTS}<br>
								${row.START_DT}<br>
								${row.END_DT}<br>
								${row.PENALTY_NAME}<br>
								${row.FAIL_RECEIVER }<br>
								${row.CREATE_DT }
							</p>
						</article>
					 </c:forEach>
				</div>
			</section>
		</c:when>
		<c:otherwise>
		 	작성된 목표가 없습니다. 어서 목표를 등록하세요!
		</c:otherwise>
	</c:choose>
	
</center>

<%@ include file="/WEB-INF/include/foot.jsp" %>
</html>