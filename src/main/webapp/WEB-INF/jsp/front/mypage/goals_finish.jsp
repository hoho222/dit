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

<center>

	<div id="" class="section">
		<div class="s-container">
			<h2 class="section-title" style="transform: translateY(0px); opacity: 1;">FINISH</h2>
		</div>
	</div>

	<c:choose>
		<c:when test="${fn:length(goalList) > 0}">
			<section class="carousel">
				<div class="reel">
					<c:forEach items="${goalList }" var="row" varStatus="status">
						<c:choose>
							<c:when test="${row.IS_SUCCESS eq 'Y'}">
								<a href="${pageContext.request.contextPath}/mypages/goals/${row.IDX}">
									<article style="background-color: #f9d9e4; border: 2px solid; border-radius: 12px; border-color:#f9d9e4;">
										<h3>SUCCESS <span class="glyphicon glyphicon-thumbs-up"></span></h3><br>
										NO. ${status.count}<br>
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
											</c:choose><br>
											${row.START_DT}<br>
											${row.END_DT}<br>
											${row.PENALTY_NAME}<br>
											${row.FAIL_RECEIVER }<br>
											<span class="glyphicon glyphicon-pencil">${fn:substring(row.CREATE_DT,0,10)}</span>
										</p>
									</article>
								</a>
							</c:when>
							<c:when test="${row.IS_SUCCESS eq 'N'}">
								<a href="${pageContext.request.contextPath}/mypages/goals/${row.IDX}">
									<article style="background-color: #bbbbbb; border: 2px solid; border-radius: 12px; border-color:#bbbbbb;">
										<h3>FAIL <span class="glyphicon glyphicon-thumbs-down"></span></h3><br>
										NO. ${status.count}<br>
										<header>
											<c:choose>
										        <c:when test="${fn:length(row.GOAL_TITLE) > 8}">
													<h3>${fn:substring(row.GOAL_TITLE,0,7)}...</a></h3>
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
											</c:choose><br>
											${row.START_DT}<br>
											${row.END_DT}<br>
											${row.PENALTY_NAME}<br>
											${row.FAIL_RECEIVER }<br>
											<span class="glyphicon glyphicon-pencil">${fn:substring(row.CREATE_DT,0,10)}</span>
										</p>
									</article>
								</a>
							</c:when>
							<c:otherwise>
								미완료거나 유효하지 않은 목표 건 입니다.	
							</c:otherwise>
						</c:choose>
					 </c:forEach>
				 </div>
			 </section>
		</c:when>
		<c:otherwise>
		 	완료한 목표가 없습니다ㅠㅠ..
		</c:otherwise>
	</c:choose>
</center>
</body>
<%@ include file="/WEB-INF/include/foot.jsp" %>
</html>