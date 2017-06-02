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
						<a href="${pageContext.request.contextPath}/goals/${row.IDX}">
							<article class="round-border">
								<p class="image featured">NO. ${status.count}</p><br>
								<header>
									<c:choose>
								        <c:when test="${fn:length(row.GOAL_TITLE) > 8}">
											<h3>${fn:substring(row.GOAL_TITLE,0,7)}...</h3>
										</c:when>
										<c:otherwise>
											<h3>${row.GOAL_TITLE }</h3>
										</c:otherwise>
									</c:choose>
								</header>
								<p>
									<c:choose>
								        <c:when test="${fn:length(row.GOAL_CONTENTS) > 14}">
											${fn:substring(row.GOAL_CONTENTS,0,13)}...
										</c:when>
										<c:otherwise>
											${row.GOAL_CONTENTS}
										</c:otherwise>
									</c:choose>
									<br>
									${row.START_DT}<br>
									${row.END_DT}<br>
									${row.PENALTY_NAME}<br>
									${row.FAIL_RECEIVER }<br>
									<span class="glyphicon glyphicon-pencil">${fn:substring(row.CREATE_DT,0,10)}</span>
								</p>
							</article>
						</a>
					 </c:forEach>
				</div>
			</section>
		</c:when>
		<c:otherwise>
			<div style="margin: 5% 0 10% 0;">
		 		작성된 목표가 없습니다. 어서 목표를 등록하세요!
		 	</div>
		</c:otherwise>
	</c:choose>
	
</center>

<%@ include file="/WEB-INF/include/foot.jsp" %>
</html>