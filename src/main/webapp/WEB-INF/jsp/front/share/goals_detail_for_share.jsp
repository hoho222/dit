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
			<h2 class="section-title" style="transform: translateY(0px); opacity: 1;">서약서</h2>
		</div>
	</div>

	<div id="myGoal" class="bgig">
		<div>
			
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
			
			<c:if test="${goalMap.HAS_GOAL_CHECK_PERIOD == 'Y'}">
				<div id="period">
					<input type="hidden" id="goalCheckPeriodHit" value="${goalMap.GOAL_CHECK_PERIOD_HIT}"/>
					<input type="hidden" id="goalCheckPeriod" value="${goalMap.GOAL_CHECK_PERIOD}"/>
					<input type="hidden" id="totalPeriodDays"/>
					<br>
					총 <span style="font-size:1.4em; color:#73730c;">${goalMap.TOTAL_DAYS}</span> 일, <span style="font-size:1.9em; color:#b72058;">${goalMap.GOAL_CHECK_PERIOD}</span> 일 마다 한번씩 체크하기 MISSON
					<br>
					
					<br>
					<div style="margin:5px 0 2px 0; overflow:auto; width:320px; height:200px;">
						<c:forEach begin="1" end="${totalPeriodDayss}" varStatus="no">
						
							<c:if test="${no.count % 2 == 0 }">
								<div class="w3-border w3-col m2 w3-center w3-grey">
								    <p>
								    	<span style="font-size: small;">${no.count}</span>
								    	<c:if test="${no.count le goalMap.GOAL_CHECK_PERIOD_HIT}">
								    		<span class="glyphicon glyphicon-ok" style="float: right;"></span>
								    	</c:if>
								    </p>
					  			</div>
							</c:if>
							<c:if test="${no.count % 2 != 0 }">
								<div class="w3-border w3-col m2 w3-center w3">
								    <p>
								    	<span style="font-size: small;">${no.count}</span>
								    	<c:if test="${no.count le goalMap.GOAL_CHECK_PERIOD_HIT}">
								    		<span class="glyphicon glyphicon-ok" style="float: right;"></span>
								    	</c:if>
								    </p>
					  			</div>
							</c:if>
						
						</c:forEach>
					</div>
					<br>
				</div>
			</c:if>
		</div>
	</div>
	<hr>
	<div id="commentRead">
		<header>
			<h2>Comment<strong> View</strong></h2>
		</header>
		<c:choose>
	        <c:when test="${fn:length(goalCommentList) > 0}">
	        <form name="commentEditFrm" method="post">
				<input type="hidden" name="mode" value=""/>
                <input type="hidden" name="contentsNew" value=""/>
                <input type="hidden" name="commentIdx" value=""/>
                <input type="hidden" name="goalIdx" value="${idx}"/>
                
	            <c:forEach items="${goalCommentList }" var="row">
	            	<div class="container" style="padding-top:20px;text-align:center;">
	                	<div class="w3-border w3-round-xlarge" style="background-color: #f9d9e4;">
                  			<div class="panel-body" >
			            		<c:if test="${row.ORIGINAL_FILE_NAME ne 'none' && row.ORIGINAL_FILE_NAME ne ''}">
				            		<img alt="${row.ORIGINAL_FILE_NAME }" src="<c:url value='/resources/comment_imgs/${row.STORED_FILE_NAME }'/>" onerror='this.src="/doto/resources/imgs/cannotloadimg.jpg"' style="width: 200px; height: 140px;" >
				            	</c:if>
				                <span id="contentsOld_${row.IDX }">${row.CONTENTS}</span>
				                <input type="text" id="contentsNew_${row.IDX }" value="${row.CONTENTS}" style="display:none"/>
				                &nbsp; 
				                ${row.CREATE_DT }
				                
							</div>
						</div>
		            </div>
                </c:forEach>
                </form>
            </c:when>
            
            <c:otherwise>
                등록된 코멘트가 없습니다.
            </c:otherwise>
            
        </c:choose>
        
	</div>
	
	<hr>
</center>

</body>
<%@ include file="/WEB-INF/include/foot.jsp" %>
</html>