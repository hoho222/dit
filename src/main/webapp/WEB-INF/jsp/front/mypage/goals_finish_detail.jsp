<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<%@ include file="/WEB-INF/include/gnb.jsp" %>
<%@ include file="/WEB-INF/include/top.jsp" %>
<%@ include file="/WEB-INF/include/head.jsp" %>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script type="text/javascript">

</script>

</head>
<body>

<c:choose> 
	<c:when test="${goalMap.IS_SUCCESS == 'Y'}">
		성공한 목표입니다 :)
	</c:when>
	<c:when test="${goalMap.IS_SUCCESS == 'N'}">
		실패한 목표입니다 T^T
	</c:when>
	<c:otherwise></c:otherwise>
</c:choose>


<center>
<h2>나의 다짐(지난 내역 입니다.)</h2>

<div id="myGoal">
	${goalMap.WRITER_ID} 은(는) ${goalMap.START_DT} 부터<br>
	${goalMap.END_DT} 까지 ${goalMap.GOAL_TITLE} 을(를) 할 것입니다. <br>
	만약 목표 달성 실패 시, ${goalMap.FAIL_RECEIVER} 에게<br>
	${goalMap.PENALTY_NAME} 을(를) 줄 것입니다.<br>
	<c:choose>
		<c:when test="${goalMap.IS_KAKAO_NOTICE == 'Y'}">
			카카오톡 알림으로 도움을 받겠습니다.
		</c:when>
		<c:when test="${goalMap.IS_KAKAO_NOTICE == 'N'}">
			카카오톡 알림으로 도움을 받지않습니다.
		</c:when>
		<c:otherwise>
			카카오톡 알림 설정이 안되어있습니다.
		</c:otherwise>
	</c:choose>
	
	<div id="btn">
		<a href="${pageContext.request.contextPath}/mypages/goals"><input type="button" class="btn btn-default" value="목록으로"/></a>
		<input type="button" class="btn btn-primary" value="페이스북"/>
	</div>	
</div>
<br>

<br>
<div id="comment">
	<div id="commentRead">
		<strong>소감</strong>
		<br>
		
		<c:choose>
	        <c:when test="${fn:length(resultMap) > 0}">
	            	<div class="round-border">
	            		<c:if test="${resultMap.ORIGINAL_FILE_NAME ne 'none' && resultMap.STORED_FILE_NAME ne ''}">
		            		<img alt="${resultMap.ORIGINAL_FILE_NAME }" src="<c:url value='/resources/result_imgs/${resultMap.STORED_FILE_NAME}'/>" style="width: 200px; height: 140px;" >
		            	</c:if>
		                ${resultMap.CONTENTS} &nbsp; ${resultMap.CREATE_DT }
		            </div>
            </c:when>
            <c:otherwise>
                등록된 코멘트가 없습니다.
            </c:otherwise>
        </c:choose>
        
	</div>
</div>
<br>
</center>

</body>
<%@ include file="/WEB-INF/include/foot.jsp" %>
</html>