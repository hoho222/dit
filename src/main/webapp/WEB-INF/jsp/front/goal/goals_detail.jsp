<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<%@ include file="/WEB-INF/include/gnb.jsp" %>
<%@ include file="/WEB-INF/include/top.jsp" %>
<%@ include file="/WEB-INF/include/head.jsp" %>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<!-- 페이스북 공유 버튼 -->
<meta property="og:url"           content="http://doit2gether.tk/doto/shares/${idx}" />
<meta property="og:type"          content="website" />
<meta property="og:title"         content="DIT.DoIt Together-!" />
<meta property="og:description"   content="당신의 목표와 함께합니다. DoIt Together!" />
<meta property="og:image"         content="http://doit2gether.tk/resources/imgs/logo.png" />

<script type="text/javascript">

function validSubmit() {
	var f = document.commentFrm;
	
	if(f.comment.value == ""){
		alert("코멘트를 입력해주세요!");
		f.comment.focus();
		return false;
	}
	
	f.action = "comments";
	f.submit();
}

function checkToday() {
	
	if(${goalMap.GOAL_CHECK_PERIOD_HIT} >= document.getElementById("totalPeriodDays").value){
		alert("주기 체크가 모두 완료된 상태 입니다.\n'목표 결과 확인'버튼을 눌러 성공여부를 판단해 보세요!");
		return false;
	} else {
		var check = confirm("목표 체크를 하시겠습니까?");
		if(check) {
			$.ajax({
			   type : 'POST',  
			   data:"periodHit="+ ${goalMap.GOAL_CHECK_PERIOD_HIT} + "&periodTotal=" + document.getElementById("totalPeriodDays").value + "&idx=" + ${idx},
			   dataType : 'text',
			   url : 'update_goal_period_hit',  
			   success : function(rData, textStatus, xhr) {
				   if(rData=='pass'){
					   alert("짝짝짝! 축하합니다.\n오늘도 목표에 한 걸음 더 가까워지셨네요!!")
					   location.reload(true);
				   } else if(rData=='fail1') {
					   alert("주기일 체크 실패T^T\n\n"+
							 "이런..! 오늘은 이미 체크를 하셨네요!\n"+
						     "주기일에 맞춰 체크해주세요 :)\n");
				   } else if(rData=='fail2') {
					   alert("주기일 체크 실패T^T\n\n"+
							 "이번 주기에는 이미 체크가 되었습니다!\n"+
					     	 "주기일에 맞춰 체크해주세요 :)\n");
				   } else if(rData=='fail3') {
					   alert("주기일 체크 실패T^T\n\n"+
							 "오늘이 종료일이거나 종료일이 지났습니다!\n"+
					     	 "종료일이 지나면 체크하실 수 없습니다.\n");
				   } else if(rData=='fail4') {
					   alert("주기일 체크 실패T^T\n\n"+
							 "아직 시작일이 되지 않았습니다.\n"+
					     	 "시작일부터 체크를 시작해주세요 :)\n");
				   } else {
					   alert("주기일 체크 실패T^T\n\n");
				   }
			   },
			   error : function(xhr, status, e) {  
			       alert("목표 주기 체크처리를 할 수 없습니다!");
			   	   console.log("목표 주기 체크처리 에러 원인 >> "+e);
			   }
			});
		} else {
			alert("취소하셨습니다.");
		}
	}
}

function resultSumbit() {
	var f = document.resultFrm;
	
	if(f.resultContents.value == ""){
		alert("소감을 입력해주세요!");
		f.resultContents.focus();
		return false;
	}
	
	f.action = "results";
	f.submit();
}

function resultCheck() {
	var goalCheckPeriodHit = document.getElementById("goalCheckPeriodHit").value;
	var goalCheckPeriod = document.getElementById("goalCheckPeriod").value;
	
	if(goalCheckPeriodHit != goalCheckPeriod) {
    	document.getElementById("successGB").value = "fail";
        document.getElementById("GB").innerHTML = "아쉽습니당 T^T";
	} else if (goalCheckPeriodHit == goalCheckPeriod) {
        document.getElementById("successGB").value = "success";
        document.getElementById("GB").innerHTML = "목표 달성을 축하합니다!! :)";
	}
	
}

//코멘트에서 '수정' 버튼 눌렀을 때
function commentEdit(commentIdx) {
	
	//기존 댓글 안보이게
	var commentOld = document.getElementById("contentsOld_"+commentIdx);
	commentOld.style.display = 'none';
	
	//새로 수정한 댓글 보이게
	var commentNew = document.getElementById("contentsNew_"+commentIdx);
	commentNew.style.display = 'block';
	
	//수정버튼 안보이게
	var editBtn = document.getElementById("editBtn_"+commentIdx);
	editBtn.style.display = 'none';
	
	//등록버튼 보이게
	var editFinBtn = document.getElementById("editFinBtn_"+commentIdx);
	editFinBtn.style.display = 'block';
    
}

function commentEditFin(commentIdx) {
	var f = document.commentEditFrm;
	var contentsNew = document.getElementById("contentsNew_"+commentIdx).value;
	
	f.contentsNew.value = contentsNew;
	f.mode.value = "EDIT";
	f.commentIdx.value = commentIdx;
	
	if(f.contentsNew.value == ""){
		alert("수정할 코멘트 내용을 입력해주세요!");
		document.getElementById("contentsNew_"+commentIdx).focus();
		return false;
	}
	
	f.action = "comments_action";
	f.submit();
}

function commentDel(commentIdx) {
	var f = document.commentEditFrm;
	f.mode.value = "DEL";
	f.commentIdx.value = commentIdx;
	
	if(confirm("해당 코멘트를 삭제하시겠습니까?")){
		f.action = "comments_action";
		f.submit();
	}
	
}

$(function() {
	
		var totalDays = ${goalMap.TOTAL_DAYS};
		var periodDays = ${goalMap.GOAL_CHECK_PERIOD};
		if(periodDays != 0){
			var totalPeriodDays = Math.floor(totalDays/periodDays);
			document.getElementById("totalPeriodDays").value = totalPeriodDays;
//			document.getElementById("totalPeriodDaysHtml").innerHTML = totalPeriodDays;
		}
	
	//모달 팝업창 열림(성공)
    $('#activeModalSuccess').on("click", function () {
        document.getElementById("successGB").value = "success";
        document.getElementById("GB").innerHTML = "목표 달성을 축하합니다!! ><";
    });
	
  	//모달 팝업창 열림(실패)
    $('#activeModalFail').on("click", function () {
    	document.getElementById("successGB").value = "fail";
        document.getElementById("GB").innerHTML = "아쉽습니당 ㅜㅜ";
    });
  	
  	//코멘트 내용 수정할 글 text박스 첨에는 안보이게
  	$("#editFinBtn").hide();
  	
});

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
					<%-- ${goalMap.GOAL_CHECK_PERIOD_HIT} / <span id="totalPeriodDaysHtml"></span>  --%>
					<input type="button" value="Check!" onclick="checkToday();"/>
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

	<c:choose>
		<c:when test="${goalMap.HAS_GOAL_CHECK_PERIOD == 'Y'}">
			
			<div id="goalBtn">
				<a href="${pageContext.request.contextPath}/goals"><input type="button" class="btn btn-default" value="목록으로"/></a>
				
				<fmt:parseNumber var="totalPeriodDays2" integerOnly="true" value="${goalMap.TOTAL_DAYS / goalMap.GOAL_CHECK_PERIOD}"/>
				
				<jsp:useBean id="now" class="java.util.Date" />
				<fmt:parseDate value="${goalMap.END_DT}" pattern="yyyy-MM-dd" var="endDate" />
				 
				<fmt:formatDate value="${now}" pattern="yyyy-MM-dd" var="nowDate" />             <%-- 오늘날짜 --%>
				<fmt:formatDate value="${endDate}" pattern="yyyy-MM-dd" var="closeDate"/>        <%-- 종료날짜 --%>
				
				<c:if test="${closeDate le nowDate}">
					<c:choose>
						<c:when test="${goalMap.GOAL_CHECK_PERIOD_HIT ge totalPeriodDays2}">
							<input type="button" class="btn btn-success" data-toggle="modal" data-target="#myModalResult" id="activeModalSuccess" value="목표 결과 확인"/>
						</c:when>
						<c:otherwise>
							<input type="button" class="btn btn-success" data-toggle="modal" data-target="#myModalResult" id="activeModalFail" value="목표 결과 확인"/>
						</c:otherwise>
					</c:choose>
				</c:if>
				
			</div>
		</c:when>
		<c:otherwise>
			<br>
			<c:if test="${goalMap.IS_SUCCESS eq 'D'}">
				<div id="goalBtn">
					<a href="${pageContext.request.contextPath}/goals"><input type="button" class="btn btn-default" value="목록으로"/></a>
					<input type="button" class="btn btn-success" data-toggle="modal" data-target="#myModalResult" id="activeModalSuccess" value="목표달성"/>
					<input type="button" class="btn btn-danger" data-toggle="modal" data-target="#myModalResult" id="activeModalFail" value="목표실패"/>
				</div>
			</c:if>
		</c:otherwise>
	</c:choose>
	
	<!-- Load Facebook SDK for JavaScript -->
	<div id="fb-root"></div>
	<script>
	(function(d, s, id) {
		 var js, fjs = d.getElementsByTagName(s)[0];
		 if (d.getElementById(id)) return;
		 js = d.createElement(s); js.id = id;
		 js.src = "//connect.facebook.net/ko_KR/sdk.js#xfbml=1&version=v2.9&appId=215782768897692";
		 fjs.parentNode.insertBefore(js, fjs);
	}(document, 'script', 'facebook-jssdk'));
	</script>	
	<div class="fb-share-button" data-href="http://doit2gether.tk/doto/shares/${idx}" data-layout="button" data-size="large" data-mobile-iframe="true"><a class="fb-xfbml-parse-ignore" target="_blank" href="https://www.facebook.com/sharer/sharer.php?u=http%3A%2F%2Fdoit2gether.tk%2Fdoto%2Fshares%2F%24%257Bidx%257D&amp;src=sdkpreparse">공유하기</a></div>
				  
	
	<!-- 목표 달성/실패 소감 작성하는 모달 팝업 -->
	<div class="modal fade" id="myModalResult" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true" >
	    <div class="modal-content">
		    <div class="modal-body">
		    	<form name="resultFrm" method="post" enctype="multipart/form-data">
		    		<input type="hidden" name="goalIdx" value="${idx}"/>
					<input type="hidden" name="writerIdx" value="${goalMap.WRITER_IDX}"/>
				    <input type="hidden" id="successGB" name="successGB" value=""/>
				    <center>
				    	<p id="GB"></p>
						<br>소감을 적어 기록하세요 :)<br>
						<textarea name="resultContents" rows="3" cols="60"></textarea>
					</center>
					<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
					<input type="file" id="fileuploaderResult" name="fileuploaderResult"/>
		        	<button type="button" class="btn btn-primary" onclick="resultSumbit();">작성</button>
		        	
		        </form>
	    	</div>
	    </div>
  	</div>


<hr>
<div id="comment" style="margin-top:10%;">
	
	<div id="commentWrite">
		<header>
			<h2>Comment<strong> Reg</strong></h2>
		</header>
		<div class="container" style="padding-top:20px;text-align:center;">
           	<div class="w3-border w3-round-xlarge w3-pale-grey">
        		<div class="panel-body" >
					<form name="commentFrm" method="post" enctype="multipart/form-data">
						<input type="hidden" name="goalIdx" value="${idx}"/>
						<input type="hidden" name="writerIdx" value="${goalMap.WRITER_IDX}"/>
						<textarea name="comment" rows="3" cols="60" placeholder="의견을 남겨주세요."></textarea>
						<br>
						<input type="file" id="fileuploader" name="fileuploader"/>
						<input type="submit" class="btn btn-default btn-sm" value="등록" onclick="validSubmit();"/>
					</form>
				</div>
			</div>
		</div>
	</div>
	<br>
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
				                ${fn:substring(row.CREATE_DT,0,10)}
				                
				                <input type="button" class="btn btn-default btn-xs" id="editBtn_${row.IDX }" value="수정" onclick="commentEdit(${row.IDX });"/>
				                <input type="button" class="btn btn-default btn-xs" id="editFinBtn_${row.IDX }" value="등록" onclick="commentEditFin(${row.IDX });" style="display:none"/>
								<input type="button" class="btn btn-default btn-xs" value="삭제" onclick="commentDel(${row.IDX });"/>
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
</div>
<hr>
</center>

</body>
<%@ include file="/WEB-INF/include/foot.jsp" %>
</html>