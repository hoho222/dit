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

<center>
<div id="" class="section">
	<div class="s-container">
		<h2 class="section-title" style="transform: translateY(0px); opacity: 1;">지난목표</h2>
	</div>
</div>

<div id="myGoal" class="bgig-finish">
	<c:choose> 
		<c:when test="${goalMap.IS_SUCCESS == 'Y'}">
			<span style="font-size:x-large;">성공한 목표입니다<span class="glyphicon glyphicon-thumbs-up"></span></span><br>
		</c:when>
		<c:when test="${goalMap.IS_SUCCESS == 'N'}">
			<span style="font-size:x-large;">실패한 목표입니다<span class="glyphicon glyphicon-thumbs-down"></span></span><br>
		</c:when>
		<c:otherwise></c:otherwise>
	</c:choose>
	${goalMap.WRITER_NAME} 은(는)<br>
	<span style="font-size:1.2em;">${goalMap.START_DT}</span> 부터<br>
	<span style="font-size:1.2em;">${goalMap.END_DT}</span> 까지<br>
	<span style="font-size:1.5em; color:#b72058; font-weight: bold;">${goalMap.GOAL_TITLE}</span> 을(를) 할 것입니다. <br>
	<c:if test="${goalMap.FAIL_RECEIVER != '' and goalMap.PENALTY_NAME != ''}">
		만약 목표 달성 실패 시, ${goalMap.FAIL_RECEIVER} 에게<br>
		${goalMap.PENALTY_NAME} 을(를) 줄 것입니다.<br>
	</c:if>
	
	<c:choose>
		<c:when test="${goalMap.IS_KAKAO_NOTICE == 'Y'}">
			<span style="font-size:0.7em;">카카오톡 알림으로 도움을 받겠습니다.</span>
		</c:when>
		<c:when test="${goalMap.IS_KAKAO_NOTICE == 'N'}">
			<span style="font-size:0.7em;">카카오톡 알림으로 도움을 받지않습니다.</span>
		</c:when>
		<c:otherwise>
			<span style="font-size:0.7em;">카카오톡 알림 설정이 안되어있습니다.</span>
		</c:otherwise>
	</c:choose>
	
</div>

<div id="btn">
	<a href="${pageContext.request.contextPath}/mypages/goals"><input type="button" class="btn btn-default" value="목록으로"/></a>
	<input type="button" class="btn btn-primary" value="페이스북"/>
</div>	

<hr>
<div id="comment" style="margin-top:5%;">
	<div id="commentRead">
		<header>
			<h2><strong>소감</strong></h2>
		</header>
		<c:choose>
	        <c:when test="${fn:length(resultMap) > 0}">
	            	<div class="container" style="padding-top:20px;text-align:center;">
	                	<div class="w3-border w3-round-xlarge" style="background-color: #f9d9e4;">
                  			<div class="panel-body" >
			            		<c:if test="${resultMap.ORIGINAL_FILE_NAME ne 'none' && resultMap.STORED_FILE_NAME ne ''}">
				            		<img alt="${resultMap.ORIGINAL_FILE_NAME }" src="<c:url value='/resources/result_imgs/${resultMap.STORED_FILE_NAME}'/>" style="width: 200px; height: 140px;" >
				            	</c:if>
				                ${resultMap.CONTENTS} &nbsp; ${resultMap.CREATE_DT }
				            </div>
				        </div>
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