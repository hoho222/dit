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
	<c:choose>
		<c:when test="${fn:length(goalList) > 0}">
			<c:forEach items="${goalList }" var="row">
				<c:choose>
				<c:when test="${row.IS_SUCCESS eq 'Y'}">
					<div class="round-border" style="background-color: #D4F4FA">
						SUCCESS! :)<br>
						<a href="${pageContext.request.contextPath}/mypages/goals/${row.IDX}">${row.GOAL_TITLE }</a><br>
						${row.GOAL_CONTENTS}<br>
						${row.START_DT}<br>
						${row.END_DT}<br>
						${row.PENALTY_NAME}<br>
						${row.FAIL_RECEIVER }<br>
						${row.CREATE_DT }
					</div>
				</c:when>
				<c:when test="${row.IS_SUCCESS eq 'N'}">
					<div class="round-border" style="background-color: #FFD9EC">
						FAIL ;(<br>
						<a href="${pageContext.request.contextPath}/mypages/goals/${row.IDX}">${row.GOAL_TITLE }</a><br>
						${row.GOAL_CONTENTS}<br>
						${row.START_DT}<br>
						${row.END_DT}<br>
						${row.PENALTY_NAME}<br>
						${row.FAIL_RECEIVER }<br>
						${row.CREATE_DT }
					</div>
				</c:when>
				<c:otherwise>
					미완료거나 유효하지 않은 목표 건 입니다.	
				</c:otherwise>
						
				</c:choose>
			 </c:forEach>
		</c:when>
		<c:otherwise>
		 	완료한 목표가 없습니다ㅠㅠ..
		</c:otherwise>
	</c:choose>
</center>
</body>
<%@ include file="/WEB-INF/include/foot.jsp" %>
</html>