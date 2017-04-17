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

<a href="goalsform"><input type="button" class="btn btn-primary btn-sm" value="목표 설정하기"/></a>

<center>
	<c:choose>
		<c:when test="${fn:length(goalList) > 0}">
			<c:forEach items="${goalList }" var="row">
				<div class="round-border">
					<a href="${pageContext.request.contextPath}/goals/${row.IDX}">${row.GOAL_TITLE }</a><br>
					${row.GOAL_CONTENTS}<br>
					${row.START_DT}<br>
					${row.END_DT}<br>
					${row.PENALTY_NAME}<br>
					${row.FAIL_RECEIVER }<br>
					${row.CREATE_DT }
				</div>
			 </c:forEach>
		</c:when>
		<c:otherwise>
		 	작성된 목표가 없습니다. 어서 목표를 등록하세요!
		</c:otherwise>
	</c:choose>
</center>

</body>
<%@ include file="/WEB-INF/include/foot.jsp" %>
</html>